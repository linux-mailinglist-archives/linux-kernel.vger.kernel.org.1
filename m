Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2D2B2D23
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKNMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:34:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:35763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKNMev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605357176;
        bh=kZIeI3cpWWIfjsUKcxtJgaN82zmB/B3WIlGIEgdXIKQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Q1ASGBoxbqMRdBVj05eYjnz/UVQB7H1MRC2mOZqpxv92v7VLlbibkFbqlBMpSYIGk
         ADbKph8uyQDRq1dzlj9j25CqirTA50oVjp+IR6Trxf+jEv/Ncdy8hp1mSV0mbvtvkL
         sqHRkKbdTryxRI+2zhkY/p062TfzgTQn/3dSiT/0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.4.129] ([130.180.109.134]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1kLHca4AiJ-00rsVQ; Sat, 14
 Nov 2020 13:32:56 +0100
Subject: Re: [SPECIFICATION RFC] The firmware and bootloader log specification
To:     Daniel Kiper <daniel.kiper@oracle.com>, coreboot@coreboot.org,
        grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        systemd-devel@lists.freedesktop.org,
        trenchboot-devel@googlegroups.com, u-boot@lists.denx.de,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     alecb@umass.edu, alexander.burmashev@oracle.com,
        allen.cryptic@gmail.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, btrotter@gmail.com,
        dpsmith@apertussolutions.com, eric.devolder@oracle.com,
        eric.snowberg@oracle.com, hpa@zytor.com, hun@n-dimensional.de,
        javierm@redhat.com, joao.m.martins@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, leif@nuviainc.com,
        lukasz.hawrylko@intel.com, luto@amacapital.net,
        michal.zygowski@3mdeb.com, mjg59@google.com, mtottenh@akamai.com,
        phcoder@gmail.com, piotr.krol@3mdeb.com, pjones@redhat.com,
        pmenzel@molgen.mpg.de, roger.pau@citrix.com,
        ross.philipson@oracle.com, tyhicks@linux.microsoft.com
References: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
From:   Nico Huber <nico.h@gmx.de>
Message-ID: <f0845d6b-deab-957f-0807-1e989a6648ac@gmx.de>
Date:   Sat, 14 Nov 2020 13:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jCHuGTunOyoefZN86kbCZvbJrL+v2T9SdYi01NqLn7tdJqgUEu1
 DFR2J86cR49a3jMkBqz6fJ74dEjADhWUImgCOeWycwDKktYUsufN+Rvu89QpE2TrC2PdDDL
 El8Bf5V/LXbDchcdPkayJv5bd6wnGbAf5jRyc3+TMNWR0UVo+LjTCB5s4JB8xr6TquVqfVd
 QJ95OUo9pDF1ed3hB6ESA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:upNVi++e/6c=:NYJXVDYgJk53X9Z/xlMWCq
 NZjo31Tp7fFfuLKOCZxb5OTh2AWdt3GF21SabTPAh92Uv/A+FzlNmFDetqN6IKBEn4A0ObI1Q
 f7oxYX6gf3yzKQQM+izSfe34iBMqzEqkk5iAV8KDAsB/qvDbyE2JSH4oOlRu13L7YK3mMwPR/
 ulH+blVZm4jGGFQhmevjFrn9lM1ScbOfuZO4MJUpOe7PJzlTzwj7rOrZ5r5PMuEGn3A/AL3Ax
 We8dIc2QUPYgfirHbelGTAZ8asaImyRiRuzpI4cTW7umucQWbHkMoUsdb/10IbD+lzATNpgmR
 iU4zkcKswHGEZKKXgcQowUAg/ez14uC+jz6ZiSvA140rK+CP4//LBoznrBBxxgcAtE9c+6N6c
 XimfcnRxtwYNlq49zf+wnd1+tUZBcyESTQNp+x+RPDuUN4q8Qp0ble5L4lpbQlxAf8hrXXYrC
 DwOi/xR5m8HRp3jZTFRWBHHYNqKYqESo4eTXwna+SEfP28WxMP8YYVHQgYPSz95wGAzvUKmfj
 hrbOpLR0EzZJQyoficzEI/Fp5mwpGK5MvztSK8yWW4DMzHv1u2vhS/mpch7KoVdfy617Ul7Mt
 /WMsppAa6fbfCBZ1EKXOH/hpVv7Use4tXfjmkdwsat/p2dVG1dYIgJPiALAjM+TMuKYc52qWG
 2lQPJKDPdGphjBZPvHGHq6xSAFXaJiNWhQsi11pDqOiJQ/Eo5xLFnsnCVXX3Y3hD/5sAx0fQW
 BG7mqchi5geOJ7Uqp28RTSceQBTLepLe6jhZPhckXLt/Ho/3psavg540qSRKdbMQM9RBnS60Q
 GKIHatEe+2YtCGUwaQnWU2HsGUGcyU+DVcAOt4FpzpYo0qSE0K9m//RYGCz10EiF4FQECXTbV
 hevYxVDKAQTl983bxSbg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I think this is a good idea. Alas, as I hear for the first time about
it, I lack any context of prior discussions / context. So bear with me,
if I ask things that have already been answered.

On 14.11.20 00:52, Daniel Kiper wrote:
> The goal is to pass all logs produced by various boot components to the
> running OS. The OS kernel should expose these logs to the user space
> and/or process them internally if needed. The content of these logs
> should be human readable. However, they should also contain the
> information which allows admins to do e.g. boot time analysis.
>
> The log specification should be as much as possible platform agnostic
> and self contained. The final version of this spec should be merged into
> existing specifications, e.g. UEFI, ACPI, Multiboot2, or be a standalone
> spec, e.g. as a part of OASIS Standards. The former seems better but is
> not perfect too...
>
> Here is the description (pseudocode) of the structures which will be
> used to store the log data.

I guess using C syntax for your "pseudocode" isn't a good choice as it
can confuse people and might lead to (unportable) implementations that
try to copy this definition to C. IMHO, it's much better for a specifi-
cation to provide exact bit/byte offsets. The protocol tool [P], for
instance, can be used to draw things in ASCII. A portable C implemen-
tation could then use these offsets for proper (de)serialization with-
out structs that try to mimic the representation in memory.

> The members of struct bf_log:
>   - version: the firmware and bootloader log format version number, 1 fo=
r now,
>   - producer: the producer/firmware/bootloader/... type; the length
>     allows ASCII UUID storage if somebody needs that functionality,

So, is this always supposed to be a string?

>   - flags: it can be used to store information about log state, e.g.
>     it was truncated or not (does it make sense to have an information
>     about the number of lost messages?),

Truncation is an interesting point as I see no length for the available
space specified. I assume most implementations would want a field for
this. Otherwise they would have to track it separately.

In coreboot, we use a ring-buffer for messages as it seems more useful
to keep the most recent messages, it's also extended across reboots and
suspend/resume cycles. For this, it would need an additional pointer
where the oldest message resides, iow. where to start reading messages.

>   - next_bf_log_addr: address of next bf_log struct; none if zero

Do I understand this correctly that a later-stage boot component would
use this to add its own `bf_log` to the chain? e.g. if I start initia-
lizing hardware with coreboot and then use GRUB2 to boot, each of them
would set up its own ` bf_log` and GRUB2 would set this pointer if
possible?

> (I think
>     newer spec versions should not change anything in first 5 bf_log mem=
bers;
>     this way older log parsers will be able to traverse/copy all logs re=
gardless
>     of version used in one log or another),

Good point, which brings me to another good practice regarding such
data formats: A length field for the header. In this case the length
from the start of `bf_log` to the start of `msgs`. This would give
us backwards compatibility in case additional fields are added in
the future. And would also allow the various implementation to add
custom fields (not for communication with log parser but for their
own use).

>   - next_msg_off: the offset, in bytes, from the beginning of the bf_log=
 struct,
>     of the next byte after the last log message in the msgs[]; i.e. the =
offset
>     of the next available log message slot; it is equal to the total siz=
e of
>     the log buffer including the bf_log struct,
>   - msgs: the array of log messages,
>   - should we add CRC or hash or signatures here?
>
> The members of struct bf_log_msg:
>   - size: total size of bf_log_msg struct,

Does this include the actual message string?

>   - ts_nsec: timestamp expressed in nanoseconds starting from 0,

But what is 0? In coreboot, we log timestamps relative to the last
reset. Which, if applied to our log ring-buffer, might make things
confusing because it can contain messages from multiple boots.

>   - level: similar to syslog meaning; can be used to differentiate norma=
l messages
>     from debug messages; the exact interpretation depends on the current=
 producer
>     type specified in the bf_log.producer,
>   - facility: similar to syslog meaning; can be used to differentiate th=
e sources of
>     the messages, e.g. message produced by networking module; the exact =
interpretation
>     depends on the current producer type specified in the bf_log.produce=
r,
>   - msg_off: the log message offset in strings[],
>   - strings[0]: the beginning of log message type, similar to the facili=
ty member but
>     NUL terminated string instead of integer; this will be used by, e.g.=
, the GRUB2
>     for messages printed using grub_dprintf(),

I don't think this is a good idea. It seems you want to start a new spec
that already supports two competing formats (the `facility` field and
this string). I know it's sometimes hard to make everybody happy, but
think we should decide for a single format. I'll try to find some time
to read about this GRUB string and prior discussions.

>   - strings[msg_off]: the beginning of log message, NUL terminated strin=
g.

> There is still not fully solved problem how the logs should be presented=
 to the OS.
> On the UEFI platforms we can use config tables to do that. Then probably
> bf_log.next_bf_log_addr should not be used. On the ACPI and Device Tree =
platforms
> we can use these mechanisms to present the logs to the OSes. The situati=
on gets more
> difficult if neither of these mechanisms are present. However, maybe we =
should not
> bother too much about that because probably these platforms getting less=
 and less
> common.

There is also the question how a later-stage boot component would do
this. It might not be easy for them to adapt ACPI, for instance (and
if no `bf_log` chain is set up yet, it can't extend that either). Maybe
just leave this open. Beside references to the big ones of course, which
may need some assigned number (UEFI? ACPI?).

Nico

[P] http://www.luismg.com/protocol/
