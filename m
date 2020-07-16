Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE3222896
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgGPQwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 12:52:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2493 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgGPQwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:52:32 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 845DA1299124E69D3125;
        Thu, 16 Jul 2020 17:52:30 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 17:52:29 +0100
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
 <20200716102814.GD7036@willie-the-truck>
 <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
 <aef1e4a4-d594-f477-9029-8f4295bb9f6c@arm.com>
 <20200716113234.GA7290@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cfd36aff-94ae-2019-3331-d43fba01070b@huawei.com>
Date:   Thu, 16 Jul 2020 17:50:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716113234.GA7290@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Perhaps a silly question (I'm too engrossed in PMU world ATM to get properly
>> back up to speed on this), but couldn't this be done without cmpxchg anyway?
>> Instinctively it feels like instead of maintaining a literal software copy
>> of the prod value, we could resolve the "claim my slot in the queue" part
>> with atomic_fetch_add on a free-running 32-bit "pseudo-prod" index, then
>> whoever updates the hardware deals with the truncation and wrap bit to
>> convert it to an actual register value.
> 
> Maybe, but it's easier said than done. The hard part is figuring how that
> you have space and there's no way I'm touching that logic without a way to
> test this.
> 
> I'm also not keen to complicate the code because of systems that don't scale
> well with contended CAS [1]. If you put down loads of cores, you need an
> interconnect/coherence protocol that can handle it.

JFYI, I added some debug to the driver to get the cmpxchg() attempt rate 
while running a testharness (below):

cpus	rate
2	1.1
4	1.1
8	1.3
16	3.6
32	8.1
64	12.6
96	14.7

Ideal rate is 1. So it's not crazy high for many CPUs, but still 
drifting away from 1.

John

> 
> Will
> 
> [1] https://lore.kernel.org/lkml/20190607072652.GA5522@hc/T/#m0d00f107c29223045933292a8b5b90d2ca9b7e5c
> .
> 

//copied from Barry, thanks :)

static int ways = 64;
module_param(ways, int, S_IRUGO);

static int seconds = 20;
module_param(seconds, int, S_IRUGO);

int mappings[NR_CPUS];
struct semaphore sem[NR_CPUS];


#define COMPLETIONS_SIZE 50

static noinline dma_addr_t test_mapsingle(struct device *dev, void *buf, 
int size)
{
     dma_addr_t dma_addr = dma_map_single(dev, buf, size, DMA_TO_DEVICE);
     return dma_addr;
}

static noinline void test_unmapsingle(struct device *dev, void *buf, int 
size, dma_addr_t dma_addr)
{
     dma_unmap_single(dev, dma_addr, size, DMA_TO_DEVICE);
}

static noinline void test_memcpy(void *out, void *in, int size)
{
     memcpy(out, in, size);
}

//just a hack to get a dev h behind a SMMU
extern struct device *hisi_dev;

static int testthread(void *data)
{
     unsigned long stop = jiffies +seconds*HZ;
     struct device *dev = hisi_dev;
     char *inputs[COMPLETIONS_SIZE];
     char *outputs[COMPLETIONS_SIZE];
     dma_addr_t dma_addr[COMPLETIONS_SIZE];
     int i, cpu = smp_processor_id();
     struct semaphore *sem = data;

     for (i = 0; i < COMPLETIONS_SIZE; i++) {
         inputs[i] = kzalloc(4096, GFP_KERNEL);
         if (!inputs[i])
             return -ENOMEM;
     }

     for (i = 0; i < COMPLETIONS_SIZE; i++) {
         outputs[i] = kzalloc(4096, GFP_KERNEL);
         if (!outputs[i])
             return -ENOMEM;
     }

     while (time_before(jiffies, stop)) {
         for (i = 0; i < COMPLETIONS_SIZE; i++) {
             dma_addr[i] = test_mapsingle(dev, inputs[i], 4096);
             test_memcpy(outputs[i], inputs[i], 4096);
         }
         for (i = 0; i < COMPLETIONS_SIZE; i++) {
             test_unmapsingle(dev, inputs[i], 4096, dma_addr[i]);
         }
         mappings[cpu] += COMPLETIONS_SIZE;
     }

     for (i = 0; i < COMPLETIONS_SIZE; i++) {
         kfree(outputs[i]);
         kfree(inputs[i]);
     }

     up(sem);

     return 0;
}

void smmu_test_core(int cpus)
{
     struct task_struct *tsk;
     int i;
     int total_mappings = 0;

     ways = cpus;

     for(i=0;i<ways;i++) {
         mappings[i] = 0;
         tsk = kthread_create_on_cpu(testthread, &sem[i], i,  "map_test");

         if (IS_ERR(tsk))
             printk(KERN_ERR "create test thread failed\n");
         wake_up_process(tsk);
     }

     for(i=0;i<ways;i++) {
         down(&sem[i]);
         total_mappings += mappings[i];
     }

     printk(KERN_ERR "finished total_mappings=%d (per way=%d) (rate=%d 
per second per cpu) ways=%d\n",
     total_mappings, total_mappings / ways, total_mappings / (seconds* 
ways), ways);

}
EXPORT_SYMBOL(smmu_test_core);


static int __init test_init(void)
{
     int i;

     for(i=0;i<NR_CPUS;i++)
         sema_init(&sem[i], 0);

     return 0;
}

static void __exit test_exit(void)
{
}

module_init(test_init);
module_exit(test_exit);
MODULE_LICENSE("GPL");

