Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A152E2791DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgIYURZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:17:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55231 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgIYUPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:15:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200925193854euoutp015c550b67854ea3b3a48912096aaae1ac~4HhLwsC3y1761017610euoutp019
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 19:38:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200925193854euoutp015c550b67854ea3b3a48912096aaae1ac~4HhLwsC3y1761017610euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601062734;
        bh=Gv4WuoDgLuPcf/4weCskZZAexoC32pYfC1tS+sFCnFk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MZw8KayRAPhC9+fORqcBvzyJMjWBquhAK4RxH9hD1OUsAemj+RnxJllv1hyleF25H
         O0TdDTBnv1+1fb3QA4frslcWTqGyBDvtF+78BLp756kvF+vcodyI6dgJbkmtwjKkI2
         1ecPb9/W7re6tJNfFhYcp3ruly/oNxkTBtGXpG68=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200925193853eucas1p2e06505dbfe051aa2bd608baf3b4d46a3~4HhKoqnlp2633126331eucas1p2s;
        Fri, 25 Sep 2020 19:38:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EC.78.06318.C474E6F5; Fri, 25
        Sep 2020 20:38:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200925193852eucas1p10c459f3f90192c1079f8a8f04b872015~4HhJ1e6Jv1448714487eucas1p1v;
        Fri, 25 Sep 2020 19:38:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200925193852eusmtrp119bb5cc8ae049ce69e930cc0565d4ffa~4HhJ0y-iU1186511865eusmtrp1I;
        Fri, 25 Sep 2020 19:38:52 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-89-5f6e474cb615
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C8.AD.06017.B474E6F5; Fri, 25
        Sep 2020 20:38:52 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200925193851eusmtip29a46a92f18eb98d53a88a1546f7b6eb5~4HhJDLSgO2935329353eusmtip2-;
        Fri, 25 Sep 2020 19:38:51 +0000 (GMT)
Subject: Re: [PATCH printk v5 6/6] printk: reimplement log_cont using record
 extension
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <a51a8dd8-bc2a-9733-1f3b-ad2fd59470a0@samsung.com>
Date:   Fri, 25 Sep 2020 21:38:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRieb8/Zc047rflsaV80GTvDDEYXZZxBN8w4Lj/8yRhG2XQktRu7
        5fpDpCY7yQpDG7ZVpstUSxG2qai0Xca6JJGMVJMRFV0MyaXTKfr3vM/zvN/7Pu98DKHokM5h
        orRxvE6rjlFRMrKs7odj6eb12jDvl9dXsonZVoote2FGbHnTiIRttl2h2JpzFsQO5nwjWfuZ
        BxL2T9eIlK1M6ZCwncZ0CVs01EWzpSUXCbYzrY8OknP3TW9p7lRlG82V5i3mSgpOU1y/w0Fz
        9Zd/klzV1cJxPuc4Z73dQnJDJR5bZNtlqyP4mKiDvM4rYJdsb0NzP7m/T3m41JBJJSC7iwE5
        MYD94Fbad8KAZIwC5yGw9o9KBUGBhxG0XpoUhhDYbTfJqY78tEdSUchFkPLxnUQsBhCcvjM8
        XjCMC94GxYWzhQYK+4Chz0AJ2BVvgoJPFbTgJ/AzAoqulUsEQY4DoMXYgwRM4gVw803lxLRZ
        OBTqGjtJ0TMTGjK6J7ATDoSXFuPEowSeB4l3MgkRK6Gt2zyxEOAkBuxfeybXXgemFAslYhfo
        td+mRewOTedTSbEhEcF7RxEtFqkImk9eRqJrFbQ7RikhGoEXgdXmJdLB4LDaSIEGPANe9c0U
        l5gB6WXC7QRaDinJCtG9EEz24n9jHz59ThiRyjQtmmlaHNO0OKb/c7MQWYCUfLxeE8nrfbX8
        IU+9WqOP10Z67o7VlKDxf9f02z5yD1WOhVcjzCCVs7y+UxOmkKoP6o9oqhEwhMpVvuZxU6hC
        HqE+cpTXxYbp4mN4fTWay5Aqpdz3+sedChypjuOjeX4/r5tSJYzTnAQUdyK9bnn2rSjLDv9X
        n46BsmDjk8zPwUkJLR7FuRYzteGA6+jyJTZj8pjidXZIyFpfv9YA7xrlNeezK7eMyW8E3m30
        6c3oqv91wfzFPz8rKPiDOWOFe4Quetna+a37yt3ssvZj8/0cA275LeGbWmtytrK5QbX08aDB
        uXtw/+raiqNVKlK/V+2zmNDp1X8BCPBno3MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7o+7nnxBtceMFk0L17PZrHtynxG
        i92nvzJZXN41h83i8MSFjBaflnxjsTjee4DJ4v/jr6wW+zqAih9NmMRksfbzY3aLzZumMls8
        6nvL7sDrsXPWXXaPln232D02r9Dy2LSqk83j3blz7B4nZvxm8dg/dw1QfEm9x/otV1k8Pm+S
        C+CK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4
        efkdS8Fb8YrNXbPZGhiPC3cxcnJICJhIrOw7ytrFyMUhJLCUUaLj+V5miISMxMlpDawQtrDE
        n2tdbBBFbxklNpy6z9LFyMEhLBAhsW6NJEgNm4ChRNdbkBpODhEBb4lVr/eyg9QzC1xmlnj1
        Yik7RPMSRokdp/+xgFTxCthJXJ3wjBHEZhFQldhwex9YXFQgTuJMzws2iBpBiZMzn4DFOQXs
        Ja4tnAAWZxYwk5i3+SEzhC0v0bx1NpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSW
        Fuem5xYb6RUn5haX5qXrJefnbmIERvi2Yz+37GDsehd8iFGAg1GJh1fhaW68EGtiWXFl7iFG
        CQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5h88kriDU0NzS0sDc2NzY3N
        LJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1ME6omjq3v+bjgzdNV7svidQo+98TNJpSWa3g
        lXJKYpHWw0f7vz/Pnet+t+p0/TpLK/c+bevlLHt8lXt330sNWv5y+rf7mx6c8NJcZiVhcmKF
        1dlnlx6Hud2/IyDwRkje5YqeRMc00/NP913eMN/F2zTv+xuttguHYmtOm0p7bZoY36CXoPEo
        31aJpTgj0VCLuag4EQCoHt9oBgMAAA==
X-CMS-MailID: 20200925193852eucas1p10c459f3f90192c1079f8a8f04b872015
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200925193852eucas1p10c459f3f90192c1079f8a8f04b872015
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200925193852eucas1p10c459f3f90192c1079f8a8f04b872015
References: <20200914123354.832-1-john.ogness@linutronix.de>
        <20200914123354.832-7-john.ogness@linutronix.de>
        <f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com>
        <CGME20200925193852eucas1p10c459f3f90192c1079f8a8f04b872015@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 25.09.2020 21:08, Marek Szyprowski wrote:
> Hi John,
>
> On 14.09.2020 14:33, John Ogness wrote:
>> Use the record extending feature of the ringbuffer to implement
>> continuous messages. This preserves the existing continuous message
>> behavior.
>>
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> This patch landed recently in linux-next as commit f5f022e53b87 
> ("printk: reimplement log_cont using record extension"). I've noticed 
> that it causes a regression on my test system (ARM 32bit Samsung 
> Exynos 4412-based Trats2 board). The messages are printed correctly on 
> the serial console during boot, but then when I run 'dmesg' command, 
> the log is truncated.
>
> Here is are the last lines of the dmesg log after this patch:
>
> [    6.649018] Waiting 2 sec before mounting root device...
> [    6.766423] dwc2 12480000.hsotg: new device is high-speed
> [    6.845290] dwc2 12480000.hsotg: new device is high-speed
> [    6.914217] dwc2 12480000.hsotg: new address 51
> [    8.710351] RAMDISK: squashfs filesystem found at block 0
>
> The corresponding dmesg lines before applying this patch:
>
> [    8.864320] RAMDISK: squashfs filesystem found at block 0
> [    8.868410] RAMDISK: Loading 37692KiB [1 disk] into ram disk... /
> [    9.071670] /
> [    9.262498] /
> [    9.540711] /
> [    9.818031] done.
> [   10.660074] VFS: Mounted root (squashfs filesystem) readonly on 
> device 1:0.
> [   10.739525] EXT4-fs (mmcblk0p1): INFO: recovery required on 
> readonly filesystem
> [   10.745347] EXT4-fs (mmcblk0p1): write access will be enabled 
> during recovery
> [   10.861129] EXT4-fs (mmcblk0p1): recovery complete
> [   10.878150] EXT4-fs (mmcblk0p1): mounted filesystem with ordered 
> data mode. Opts: (null)
> [   10.881811] VFS: Mounted root (ext4 filesystem) readonly on device 
> 179:49.
> [   10.889858] Trying to move old root to /initrd ...
> [   10.895192] okay
> [   10.914411] devtmpfs: mounted
> [   10.925087] Freeing unused kernel memory: 1024K
> [   10.933222] Run /sbin/init as init process
> [   10.941723]   with arguments:
> [   10.949890]     /sbin/init
> [   10.949900]   with environment:
> [   10.949909]     HOME=/
> [   10.949917]     TERM=linux
> [   12.415991] random: systemd-udevd: uninitialized urandom read (16 
> bytes read)
> [   12.425361] random: systemd-udevd: uninitialized urandom read (16 
> bytes read)
> [   12.438578] random: systemd-udevd: uninitialized urandom read (16 
> bytes read)
>
> ...
>
> I can provide a complete logs if that helps.

One more information - this issue happens only if the kernel is compiled 
from exynos_defconfig. If use multi_v7_defconfig, the dmesg works fine 
on that board. exynos_defconfig has quite a lots of debugging options 
enabled...

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

