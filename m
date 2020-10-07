Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58B2285EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgJGMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:05:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF2C061755;
        Wed,  7 Oct 2020 05:05:59 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kQ8Cc-0001rT-Bz; Wed, 07 Oct 2020 14:05:50 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <d612f512f2e4eb00e1e80674783c1ffb5e463f82.1601541165.git.linux@leemhuis.info>
 <24dfc4c3-5c53-be63-4768-a3c8b5a42706@infradead.org>
Subject: [RFC PATCH v1 09/26] docs: reporting-bugs: help users find the proper
 place for their report
Message-ID: <b4072a18-d446-b487-ea0f-d75cdd8a7842@leemhuis.info>
Date:   Wed, 7 Oct 2020 14:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <24dfc4c3-5c53-be63-4768-a3c8b5a42706@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1602072359;b94fa1ed;
X-HE-SMSGID: 1kQ8Cc-0001rT-Bz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thx for you comments. Consider all the obvious spelling and

grammatical mistakes you pointed out fixed, I won't mention all of them

in this reply to keep things easier to follow.

Am 04.10.20 um 06:03 schrieb Randy Dunlap:
> On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
>
>> = RFC =
>>
>> This section tells users to always CC LKML. I placed this in the text here for
>> now as a way to force a general discussion about this, as it would be way easier
>> if users had one place where they could search for existing reports; maybe it
>> should be the same place where fixes are sent to, as then the single search
>> would find those, too.
>>
>> That might mean "LKML", which these days afaics is a kind of "catch-all" ml
>> anyway (which nearly nobody reads). So it might make sense to go "all in" and
>> make people send their reports here, too. But TBH I'm a bit unsure myself if
>> that's the right approach. Maybe creating a mailing list like
>> 'linux-issues@vger.kernel.org' would be best (and while at it maybe also
>> linux-regressions@vger.kernel.org).
> Yes, LKML has become an archival list for almost everything. However, bug reports
> should still be sent to their more specific list when possible, e.g., USB to
> linux-usb, ACPI to linux-acpi, networking to netdev, wireless to linux-wireless,
> SCSI to linux-scsi, etc.

Definitely, that "always CC LKML" above was meant as "in addition" ;-)

> I might be OK with one additional bug/issues/regressions mailing list but I
> wouldn't care to see that split into more than one list.

Yeah, but we care more about regression and having no way to tell them
apart from bugs might make things hard.

>> +Problem is: the Linux kernel lacks a central bug tracker that all maintainers
>> +use, so you have to find the right way and place to report issues yourself. One
>> +way to do that: look at the `MAINTAINERS file in the Linux kernel sources
>> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_,
> The MAINTAINERS list is also available via html at
> https://www.kernel.org/doc/html/latest/process/maintainers.html

Ahh, wasn't aware of that, thx for the pointer. I switched over to that 
one and use a "ref:" link. This and these comments…

> but since a reporter might need to use scripts/get_maintainer.pl, maybe the html
> doesn't help so much.
 > [...]
>> +To illustrate how to use the file lets assume the Wi-Fi in your Laptop suddenly
>> +misbehaves after updating the kernel. In that case it's likely an issue in the
>> +Wi-Fi driver; it could also be some code it builds upon: the Wi-Fi subsystem,
>> +the TCP/IP stack, which are all part of the Network subsystem. But unless you
>> +suspect the culprit lies there stick to the driver. Thus run the command
>> +``lspci -k`` to tell which kernel driver manages a particular hardware::
> 
> Other times it might be 'lsusb' or 'lsscsi' or this might not be applicable at all
> to LED drivers or pinctrl drivers or W1 or I2C or GPIO (?).
 > [...]
>> +the person has a spare minute. If it states 'Obsolete' then you are using some
>> +outdated code and should switch to the newer approach the kernel offers. If it
>> +says 'Orphan' you are out of luck: nobody takes care of the code anymore, hence
>> +there is nobody to send a report to. You need to fix this yourself or look
>> +somewhere else to find someone that is willing to help.
> or discard that particular hardware.
 > [...]
> Personally I would CC all M: people but not R: (reviewers).

…made me revisit the whole section and rewrite a few bits. This is how 
it looks like now (sorry, please ignore the long quoted lines that got 
wrapped, sending this with thunderbird instead of git-send-email):

```

Locate kernel area that causes the issue
----------------------------------------

     *Locate the driver or kernel subsystem that seems to be causing the 
issue. Find out how and where its developers expect reports. Note: most 
of the time this won't be bugzilla.kernel.org, as issues typically need 
to be sent by mail to a maintainer and a public mailing list.*

It's crucial to send your report to the right people, as the Linux 
kernel is a big project and most of its developers are only familiar 
with a small subset of it. Quite a few programmers for example only care 
for just one driver, for example one for a WiFi chip; its developer 
likely will only have small or no knowledge about the internals of more 
remote "subsystems", like the TCP stack, the PCIe/PCI subsystem, memory 
management or some other part the driver might be using.

Problem is: the Linux kernel lacks a central bug tracker where you can 
simply file your issue to reach the developers that need to know about 
it. That's why you have to find the right place and way to report issues 
yourself. You can do that with the help of a script, but it mainly 
targets kernel developers and experts. For everybody else the 
MAINTAINERS file is the better place.

How to read the MAINTAINERS file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To illustrate how to use the ref:`MAINTAINERS <maintainers>`_ file, lets 
assume the WiFi in your Laptop suddenly misbehaves after updating the 
kernel. In that case it's likely an issue in the WiFi driver. Obviously 
it could also be some code it builds upon, but unless you suspect 
something like that stick to the driver, as its developers will get the 
right people involved if it's really something else.

Sadly, there is no way to check which code is driving a particular 
hardware component that is both universal and easy. In the case of a 
WiFi driver problem there are multiple approaches to find the

You for example might want to look at the output of ``lspci -k``, as it 
lists devices on the PCI/PCIe bus and the kernel module driving it::

        [user@something ~]$ lspci -k
        [...]
        3a:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac 
Wireless Network Adapter (rev 32)
          Subsystem: Bigfoot Networks, Inc. Device 1535
          Kernel driver in use: ath10k_pci
          Kernel modules: ath10k_pci
        [...]

But this approach won't work if your WiFi chip is connected over USB or 
some other internal bus. In those cases you might want to check your 
WiFi manager or the output of ``ip link``. Look for the name of the 
problematic network interface, which might be something like 'wlp58s0'. 
This name can be used like this to find the module driving it::

        [user@something ~]$ realpath --relative-to=/sys/module/ 
/sys/class/net/wlp58s0/device/driver/module
        ath10k_pci

In case tricks like these don't bring you any further, try to search the 
internet on how to narrow down the driver or subsystem in question. And 
if you are unsure which it is: just try your best guess, somebody will 
help you if you guess poorly.

Once you know the driver or subsystem you want to search for it in the 
MAINTAINERS file. In the case of 'ath10k_pci' you won't find anything, 
as the name is too specific. Sometimes you will need to search on the 
net then; but before doing so, try to search for a somewhat shorted or 
modified name, as then you might find something like this::

        QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
        Mail:          A. Some Human <shuman@example.com>
        Mailing list:  ath10k@lists.infradead.org
        Status:        Supported
        Web-page: 
https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
        SCM:           git 
git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
        Files:         drivers/net/wireless/ath/ath10k/

Note: the line description will be abbreviations, if you read the plain 
MAINTAINERS file found in the root of the Linux source tree. 'Mail:' for 
example will be 'M:', 'Mailing list:' will be 'L', and 'Status:' will be 
'S:'. These and other abbreviations are explained near the top of the file.

First look at the line 'Status', to make sure the code is 'Supported', 
'Maintained', or at least has someone who provides 'Odd Fixes' when 
feeling motivated. If it states 'Obsolete' then you are using some 
outdated approach that was replaced by a newer solution you need to 
switch to. With 'Orphan' you are out of luck, as nobody takes care of 
the code anymore, which only leaves these options: stop trying to do 
what you want, live with the issue, fix it yourself, or find a 
programmer somewhere willing to fix it.

After checking the status, look for a line starting with 'bugs:': it 
will tell you where to find a subsystem specific bug tracker to file 
your issue. The example above does not have such a line; that is the 
case for most sections, as Linux kernel development is completely driven 
by mail and only very few subsystems use a bug tracker.

In this in many other cases you thus have to look for lines starting 
with 'Mail:' instead. Those mention the name and the email addresses for 
the maintainers of the particular code. Also look for a line starting 
with 'Mailing list:', which tells you the public mailing list where the 
code is developed. Your report later needs to go by mail to those 
addresses. Additionally, for all issue reports sent by email, make sure 
to add the Linux Kernel Mailing List (LKML) 
<linux-kernel@vger.kernel.org> to CC. Don't omit either of the mailing 
lists when sending your issue report by mail later! Maintainers are busy 
people and might leave some work for other developers on the subsystem 
specific list; and LKML is important to have one place where all issue 
reports can be found.


Finding the maintainers with the help of a script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For people that have the Linux sources at hand there is a second option 
to find the proper place to report: a script that tries to find all 
people to contact. This script is called 'get_maintainer.pl' and located 
in the scripts/ directory and relies on the MAINTAINERS file. It needs 
to be called with a path to the source code in question. For drivers 
compiled as module if often can be found with a command like this::

        $ modinfo ath10k_pci | grep filename | sed 
's!/lib/modules/.*/kernel/!!; s!filename:!!; s!\.ko\(\|\.xz\)!!'
        drivers/net/wireless/ath/ath10k/ath10k_pci.ko

Pass parts of this to the script::

        $ ./scripts/get_maintainer.pl -f drivers/net/wireless/ath/ath10k*
        Some Human <shuman@example.com> (supporter:QUALCOMM ATHEROS 
ATH10K WIRELESS DRIVER)
        Another S. Human <asomehuman@example.com> (maintainer:NETWORKING 
DRIVERS)
        ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K 
WIRELESS DRIVER)
        linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS 
(WIRELESS))
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
        linux-kernel@vger.kernel.org (open list)

Don't sent your report to all of them. Sent it to the maintainers, which 
the script calls "supporter:"; additionally CC the most specific mailing 
list for the code as well as Linux Kernel Mailing List (LKML). In this 
case you thus would need to send the report to 'Some Human 
<shuman@example.com>' with 'ath10k@lists.infradead.org' and 
'linux-kernel@vger.kernel.org' in CC.

Note: in case you cloned the Linux sources with git you might want to 
call ``get_maintainer.pl`` a second time with ``--git``. The script then 
will look at the commit history to find which people recently worked on 
the code in question, as they might be able to help. But use such 
results with care, as it can easily send you in a wrong direction. That 
for example happens quickly with areas that are rarely changed (like old 
or unmaintained drivers): this code is sometimes modified during 
tree-wide cleanups by developers that do not care about the particular 
part of the kernel at all.
```

Ciao, Thorsten
