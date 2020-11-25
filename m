Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF62C37E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 05:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgKYEIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 23:08:12 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42430 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbgKYEIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 23:08:12 -0500
Received: from [10.130.0.80] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxutCk2L1foFwWAA--.36614S3;
        Wed, 25 Nov 2020 12:08:05 +0800 (CST)
Subject: Re: [PATCH RESEND] checkpatch: Do not check git commit description
 style when backport the upstream commit
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
References: <1606275347-19297-1-git-send-email-yangtiezhu@loongson.cn>
 <dddb87a6ffb94b6b8046eb2eca1480a7ca37f962.camel@perches.com>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <995e0acb-c219-ea00-f078-7582516e25de@loongson.cn>
Date:   Wed, 25 Nov 2020 12:08:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <dddb87a6ffb94b6b8046eb2eca1480a7ca37f962.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxutCk2L1foFwWAA--.36614S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF47GrW3GF48uFyrWrWrGrg_yoW3ZFgEqr
        4kWrWkC3ykZr1qy3ZYqr4Y9FyUKayDt3W8Jr4fA3y7Ar98XFZ8JFZ3WasYvas7Ars5uFyv
        kF4jv3s3Kr4avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VAC
        jcxG62k0Y48FwI0_Jr0_Gr1lYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r
        4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRRYL9UUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/2020 11:51 AM, Joe Perches wrote:
> On Wed, 2020-11-25 at 11:35 +0800, Tiezhu Yang wrote:
>> When backport the upstream commit to the internal LTS kernel version,
>> we usually use the following description [1] [2]:
>>
>> [ Upstream commit cc6528bc9a0c901c83b8220a2e2617f3354d6dd9 ]
>> or
>> commit c51f8f88d705e06bd696d7510aff22b33eb8e638 upstream.
> Internal to what?
>
> If it's your own internal build system, I think you should
> keep your own local patch to checkpatch.
>
> I don't see why the kernel version should accept it.
>
> Is this style used by anyone else?

AFAIK, this style is only used in the stable tree, for example:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.9.y&id=c68a9ca7ca33f1020cca97e4e935c2154bec37c7

