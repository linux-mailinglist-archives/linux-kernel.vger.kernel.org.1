Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3878321EE34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGNKnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 06:43:49 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:47662 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:43:47 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jvIPW-0001w7-TI; Tue, 14 Jul 2020 10:43:43 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jvIPU-0005de-CT; Tue, 14 Jul 2020 11:43:42 +0100
Subject: Re: [PATCH v2 2/3] um: some fixes to build UML with musl
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>, johannes.berg@intel.com
References: <20200704085213.444645-1-ignat@cloudflare.com>
 <20200704085213.444645-3-ignat@cloudflare.com>
 <8b168d8c-f526-42b4-7cec-ec7c26c64122@cambridgegreys.com>
 <CALrw=nFaeMPH9GbMWwiT4rV32=uLKa3ZOYpmnkKTA3bvMiyXYg@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <72b84dca-e285-bb1f-1b69-5b29c70806d8@cambridgegreys.com>
Date:   Tue, 14 Jul 2020 11:43:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALrw=nFaeMPH9GbMWwiT4rV32=uLKa3ZOYpmnkKTA3bvMiyXYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2020 11:23, Ignat Korchagin wrote:
> On Tue, Jul 14, 2020 at 9:40 AM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
>>
>>
>> On 04/07/2020 09:52, Ignat Korchagin wrote:
>>> musl toolchain and headers are a bit more strict. These fixes enable building
>>> UML with musl as well as seem not to break on glibc.
>>>
>>> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>>> ---
>>>    arch/um/drivers/daemon_user.c |  1 +
>>>    arch/um/drivers/pcap_user.c   | 12 ++++++------
>>>    arch/um/drivers/slip_user.c   |  2 +-
>>>    arch/um/drivers/vector_user.c |  4 +---
>>>    arch/um/os-Linux/util.c       |  2 +-
>>>    arch/x86/um/user-offsets.c    |  2 +-
>>>    6 files changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
>>> index 3695821d06a2..785baedc3555 100644
>>> --- a/arch/um/drivers/daemon_user.c
>>> +++ b/arch/um/drivers/daemon_user.c
>>> @@ -7,6 +7,7 @@
>>>     */
>>>
>>>    #include <stdint.h>
>>> +#include <string.h>
>>>    #include <unistd.h>
>>>    #include <errno.h>
>>>    #include <sys/types.h>
>>> diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
>>> index bbd20638788a..52ddda3e3b10 100644
>>> --- a/arch/um/drivers/pcap_user.c
>>> +++ b/arch/um/drivers/pcap_user.c
>>> @@ -32,7 +32,7 @@ static int pcap_user_init(void *data, void *dev)
>>>        return 0;
>>>    }
>>>
>>> -static int pcap_open(void *data)
>>> +static int pcap_user_open(void *data)
>>
>> This change in the function name was introduced on purpose to avoid name clash in some version of libpcap which export pcap_open
> 
> Yes
> 
>>
>>
>>>    {
>>>        struct pcap_data *pri = data;
>>>        __u32 netmask;
>>> @@ -44,14 +44,14 @@ static int pcap_open(void *data)
>>>        if (pri->filter != NULL) {
>>>                err = dev_netmask(pri->dev, &netmask);
>>>                if (err < 0) {
>>> -                     printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
>>> +                     printk(UM_KERN_ERR "pcap_user_open : dev_netmask failed\n");
>>>                        return -EIO;
>>>                }
>>>
>>>                pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
>>>                                        UM_GFP_KERNEL);
>>>                if (pri->compiled == NULL) {
>>> -                     printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
>>> +                     printk(UM_KERN_ERR "pcap_user_open : kmalloc failed\n");
>>>                        return -ENOMEM;
>>>                }
>>>
>>> @@ -59,14 +59,14 @@ static int pcap_open(void *data)
>>>                                   (struct bpf_program *) pri->compiled,
>>>                                   pri->filter, pri->optimize, netmask);
>>>                if (err < 0) {
>>> -                     printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
>>> +                     printk(UM_KERN_ERR "pcap_user_open : pcap_compile failed - "
>>>                               "'%s'\n", pcap_geterr(pri->pcap));
>>>                        goto out;
>>>                }
>>>
>>>                err = pcap_setfilter(pri->pcap, pri->compiled);
>>>                if (err < 0) {
>>> -                     printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
>>> +                     printk(UM_KERN_ERR "pcap_user_open : pcap_setfilter "
>>>                               "failed - '%s'\n", pcap_geterr(pri->pcap));
>>>                        goto out;
>>>                }
>>> @@ -127,7 +127,7 @@ int pcap_user_read(int fd, void *buffer, int len, struct pcap_data *pri)
>>>
>>>    const struct net_user_info pcap_user_info = {
>>>        .init           = pcap_user_init,
>>> -     .open           = pcap_open,
>>> +     .open           = pcap_user_open,
>>>        .close          = NULL,
>>>        .remove         = pcap_remove,
>>>        .add_address    = NULL,
>>> diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
>>> index 8016d32b6809..482a19c5105c 100644
>>> --- a/arch/um/drivers/slip_user.c
>>> +++ b/arch/um/drivers/slip_user.c
>>> @@ -9,7 +9,7 @@
>>>    #include <errno.h>
>>>    #include <fcntl.h>
>>>    #include <string.h>
>>> -#include <sys/termios.h>
>>> +#include <termios.h>
>>>    #include <sys/wait.h>
>>>    #include <net_user.h>
>>>    #include <os.h>
>>> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
>>> index c4a0f26b2824..45d4164ad355 100644
>>> --- a/arch/um/drivers/vector_user.c
>>> +++ b/arch/um/drivers/vector_user.c
>>> @@ -18,9 +18,7 @@
>>>    #include <fcntl.h>
>>>    #include <sys/socket.h>
>>>    #include <sys/un.h>
>>> -#include <net/ethernet.h>
>>>    #include <netinet/ip.h>
>>> -#include <netinet/ether.h>
>>>    #include <linux/if_ether.h>
>>>    #include <linux/if_packet.h>
>>>    #include <sys/wait.h>
>>> @@ -332,7 +330,7 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
>>>        }
>>>        switch (id) {
>>>        case ID_BESS:
>>> -             if (connect(fd, remote_addr, sizeof(struct sockaddr_un)) < 0) {
>>> +             if (connect(fd, (const struct sockaddr *) remote_addr, sizeof(struct sockaddr_un)) < 0) {
>>>                        printk(UM_KERN_ERR "bess open:cannot connect to %s %i", remote_addr->sun_path, -errno);
>>>                        goto unix_cleanup;
>>>                }
>>> diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
>>> index ecf2f390fad2..07327425d06e 100644
>>> --- a/arch/um/os-Linux/util.c
>>> +++ b/arch/um/os-Linux/util.c
>>> @@ -10,7 +10,7 @@
>>>    #include <signal.h>
>>>    #include <string.h>
>>>    #include <termios.h>
>>> -#include <wait.h>
>>> +#include <sys/wait.h>
>>>    #include <sys/mman.h>
>>>    #include <sys/utsname.h>
>>>    #include <init.h>
>>> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
>>> index c51dd8363d25..bae61554abcc 100644
>>> --- a/arch/x86/um/user-offsets.c
>>> +++ b/arch/x86/um/user-offsets.c
>>> @@ -2,7 +2,7 @@
>>>    #include <stdio.h>
>>>    #include <stddef.h>
>>>    #include <signal.h>
>>> -#include <sys/poll.h>
>>> +#include <poll.h>
>>>    #include <sys/mman.h>
>>>    #include <sys/user.h>
>>>    #define __FRAME_OFFSETS
>>>
>>
>> Apologies for the delay in answering, I was buried under OVS for the last month or so.
>>
>> With the exception of this patch the rest of the series looks OK. Can you please resumbit and if Johannes and Richard are OK with it I will +1 it.
> 
> I didn't quite understand how I should improve this patch. Could you,
> please, clarify?

Sorry, not reading it correctly :)

My fault. You actually did exactly what has been in the queue for a while after Brendan noticed it: https://lkml.org/lkml/2019/12/5/868

Patch is OK with me, should not read patches before the 3rd double espresso next time.

I will +1 it, Richard, Johannes, what do you think?

Thanks,

> 
>> Best regards,
>>
>> --
>> Anton R. Ivanov
>> Cambridgegreys Limited. Registered in England. Company Number 10273661
>> https://www.cambridgegreys.com/
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
