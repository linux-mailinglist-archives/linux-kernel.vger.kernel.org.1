Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32C428E673
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgJNSdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:33:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58438 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgJNSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:33:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EIORWi109115;
        Wed, 14 Oct 2020 18:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IqbCE21wDs87840Vln5Uj/djp4WVmzbWEoRiJ9MBP4I=;
 b=KqYq40VfJEqHJ2kgmimuFkA/on5yEX11P0t5Y+f0szeNbSZXhJB9dREWVaRI6K+eY83H
 jYMwu6//gqxLFJGmVyW5BIm+IAi1mEUJn1d1g55nwseBhafHGOYDNodfnc0lnLgiNJ/j
 5CoXBOkogHiwxojgRmJ7nqeOLB67zGTU1vC+2xEgXbcJOMuhqxth7O98Pzt1LsB4gFre
 JZhFb9qxv9k20fcfuRAwLRwcHzq70YDOCfOlnmCTFqHqAmQrfqR8dYY7cH6/xAsaZrdo
 dbtTgs355Sbtdc+CMJ1j5ad69mYL7er0HjULyJiT/VL/7XF2i54Lr0FguLiuBRUx/nJU og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3434wks586-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 18:33:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EIPack027282;
        Wed, 14 Oct 2020 18:31:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 344by425bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 18:31:19 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09EIVImp000809;
        Wed, 14 Oct 2020 18:31:18 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 11:31:17 -0700
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at
 mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
To:     David Hildenbrand <david@redhat.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Privoznik <mprivozn@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <c1ea7548-622c-eda7-66f4-e4ae5b6ee8fc@redhat.com>
 <563d1eef-b780-835a-ebf0-88ae111b20c2@redhat.com>
 <CAHS8izPEHZunoeXYS5ONfRoSRMpC7DQwtpjJ8g4nXiddTfNoaA@mail.gmail.com>
 <65a1946f-dbf9-5767-5b51-9c1b786051d1@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5f196069-8b98-0ad3-55e8-19af03d715cd@oracle.com>
Date:   Wed, 14 Oct 2020 11:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <65a1946f-dbf9-5767-5b51-9c1b786051d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 11:18 AM, David Hildenbrand wrote:
> On 14.10.20 19:56, Mina Almasry wrote:
>> On Wed, Oct 14, 2020 at 9:15 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 14.10.20 17:22, David Hildenbrand wrote:
>>>> Hi everybody,
>>>>
>>>> Michal Privoznik played with "free page reporting" in QEMU/virtio-balloon
>>>> with hugetlbfs and reported that this results in [1]
>>>>
>>>> 1. WARNING: CPU: 13 PID: 2438 at mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
>>>>
>>>> 2. Any hugetlbfs allocations failing. (I assume because some accounting is wrong)
>>>>
>>>>
>>>> QEMU with free page hinting uses fallocate(FALLOC_FL_PUNCH_HOLE)
>>>> to discard pages that are reported as free by a VM. The reporting
>>>> granularity is in pageblock granularity. So when the guest reports
>>>> 2M chunks, we fallocate(FALLOC_FL_PUNCH_HOLE) one huge page in QEMU.
>>>>
>>>> I was also able to reproduce (also with virtio-mem, which similarly
>>>> uses fallocate(FALLOC_FL_PUNCH_HOLE)) on latest v5.9
>>>> (and on v5.7.X from F32).
>>>>
>>>> Looks like something with fallocate(FALLOC_FL_PUNCH_HOLE) accounting
>>>> is broken with cgroups. I did *not* try without cgroups yet.
>>>>
>>>> Any ideas?
>>
>> Hi David,
>>
>> I may be able to dig in and take a look. How do I reproduce this
>> though? I just fallocate(FALLOC_FL_PUNCH_HOLE) one 2MB page in a
>> hugetlb region?
>>
> 
> Hi Mina,
> 
> thanks for having a look. I started poking around myself but,
> being new to cgroup code, I even failed to understand why that code gets
> triggered though the hugetlb controller isn't even enabled.
> 
> I assume you at least have to make sure that there is
> a page populated (MMAP_POPULATE, or read/write it). But I am not
> sure yet if a single fallocate(FALLOC_FL_PUNCH_HOLE) is
> sufficient, or if it will require a sequence of
> populate+discard(punch) (or multi-threading).

FWIW - I ran libhugetlbfs tests which do a bunch of hole punching
with (and without) hugetlb controller enabled and did not see this issue.

May need to reproduce via QEMU as below.
-- 
Mike Kravetz

> What definitely makes it trigger is via QEMU
> 
> qemu-system-x86_64 \
> -machine pc-i440fx-4.0,accel=kvm,usb=off,dump-guest-core=off,memory-backend=pc.ram \
> -cpu host,migratable=on \
> -m 4096 \
> -object memory-backend-memfd,id=pc.ram,hugetlb=yes,hugetlbsize=2097152,size=4294967296 \
> -overcommit mem-lock=off \
> -smp 4,sockets=1,dies=1,cores=2,threads=2 \
> -nodefaults \
> -nographic \
> -device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x4 \
> -device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x5 \
> -blockdev '{"driver":"file","filename":"../Fedora-Cloud-Base-32-1.6.x86_64.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' \
> -blockdev '{"node-name":"libvirt-1-format","read-only":false,"discard":"unmap","driver":"qcow2","file":"libvirt-1-storage","backing":null}' \
> -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,device_id=drive-scsi0-0-0-0,drive=libvirt-1-format,id=scsi0-0-0-0,bootindex=1 \
> -chardev stdio,nosignal,id=serial \
> -device isa-serial,chardev=serial \
> -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x7,free-page-reporting=on
> 
> 
> However, you need a recent QEMU (>= v5.1 IIRC) and a recent kernel
> (>= v5.7) inside your guest image.
> 
> Fedora rawhide qcow2 should do: https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Cloud/x86_64/images/Fedora-Cloud-Base-Rawhide-20201004.n.1.x86_64.qcow2
> 
