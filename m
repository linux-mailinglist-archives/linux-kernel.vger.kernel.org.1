Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FD429187E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgJRRNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:13:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773C8C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 10:13:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x13so4575059pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:references:user-agent
         :mime-version;
        bh=o1kDeD7ljg6uvLh+dDxGFvS8iUF3Qbu/b1g15b5f+34=;
        b=uXKv5szU7drVdtHc3D0ZmRbVdP1e2CbXQ3rJemrBNDdQlXM1i1wTNWQmrTHa6mHBiM
         XtDAK08MTbY5aT/aQBLD4ee1CH8sXiahiZAIpFaRRCReHfw9LlkrK4V0PA2rMpivUd1h
         TMY66FQG/Jb8tgM4eqvdGkcv13qcX2cXlSjmMGUfRRVgsYUDc3Ygdwvfxxj6H0WO040I
         /Ov3EygW42OotuEyGluBdd247jJCQ3EkXpWvywIpdNr9DVyCgYpG7g7Mi1Mqk4MaSHlT
         fGrPZudny5Vrc1SU//dhYqoEJV39GVoT4OPgRi8ICRba6q+loKZgYq6gz3SfAqOSfZoB
         Bk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:references
         :user-agent:mime-version;
        bh=o1kDeD7ljg6uvLh+dDxGFvS8iUF3Qbu/b1g15b5f+34=;
        b=tYrV+msGX2NRm5K7gpMCXcz+S5lwhdZyibbFnZklfjYLkq0Sss7DHF2jSPojXE8LLJ
         IU7x4ANygpsCnjK2CDCH4Xo5DA+mJu3mNLmfoM3wnyomCK6AQ1f+lDIzELlk35nplqXT
         jDZ3p61OkxJr+KWI0JIi+4WD8Ist/o9WutX866yzz4unnPQgPELGLSImrnh/2a8xFTyC
         a1dhSI9i6c9JUpiPQrQjSzPs2FbW3BgWK0vvgALcAuXh80zSoR5j4nc7WjS0JtdVUlsy
         FqWUlPjJPTTCTF5EkrO3TUlvLsaMEFuA/WPNzszwJEiv5HPPwy96HqSIGoTyZ5InRRWd
         P41g==
X-Gm-Message-State: AOAM532VoKPti1e5kRxziuvcl4E0zYuY7WH0nqFPVY3L4H5RaxdX8YJD
        TOlJ6NOip5/FTIq4ytTtMt+TdpxfHZL7NA==
X-Google-Smtp-Source: ABdhPJxvzYjJyaRR+yD2baIU3U4hHEIX71+qjcHjVlT13j9rRvmz1K7198gioIKO1BHXI5r/2u850A==
X-Received: by 2002:a63:1119:: with SMTP id g25mr11101735pgl.385.1603041198050;
        Sun, 18 Oct 2020 10:13:18 -0700 (PDT)
Received: from debian ([122.183.152.57])
        by smtp.gmail.com with ESMTPSA id n6sm2031155pjj.34.2020.10.18.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 10:13:17 -0700 (PDT)
Message-ID: <b4533bcbb095cf11f01d0adfd50912c52242eb02.camel@rajagiritech.edu.in>
Subject: Fwd: [WARNING AND ERROR]  may be  system slow and  audio and video
 breaking
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        jpoimboe@redhat.com, mbenes@suse.cz,
        "peterz@infradead.org" <peterz@infradead.org>,
        shile.zhang@linux.alibaba.com
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Sun, 18 Oct 2020 22:42:39 +0530
References: <959da1eee73f58a824fe4913b5cacda6de0f392e.camel@rajagiritech.edu.in>
Content-Type: multipart/mixed; boundary="=-xDbNw6FXGP/quuFNhvZj"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xDbNw6FXGP/quuFNhvZj
Content-Type: text/plain
Content-Transfer-Encoding: base64

Cg0K


--=-xDbNw6FXGP/quuFNhvZj
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [WARNING AND
 ERROR]  may be  system slow and  audio and video breaking
Content-Type: message/rfc822

Return-Path: <jeffrin@rajagiritech.edu.in>
Received: from debian ([122.183.152.57]) by smtp.gmail.com with ESMTPSA id
 k78sm9332216pfd.194.2020.10.18.07.54.38 (version=TLS1_3
 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Sun, 18 Oct 2020 07:54:40
 -0700 (PDT)
Message-ID: <959da1eee73f58a824fe4913b5cacda6de0f392e.camel@rajagiritech.edu.in>
Subject: [WARNING AND ERROR]  may be  system slow and  audio and video
 breaking
From: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Date: Sun, 18 Oct 2020 20:24:36 +0530
Content-Type: multipart/mixed; boundary="=-+RigdPpNJraeUxG+DbEr"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0


--=-+RigdPpNJraeUxG+DbEr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,
System was slow and  audio and video
was breaking. I was compiling a kernel and also
played a youtube video in firefox and  maybe evolution.

meminfo.txt  and lscpu.txt files are attached.

The following is a part from "dmesg -l warn"

-------------------x--------------x-------------x------------
smpboot: Scheduler frequency invariance went wobbly, disabling!
[ 1112.592866] unchecked MSR access error: RDMSR from 0x123 at rIP:
0xffffffffb5c9a184 (native_read_msr+0x4/0x30)
[ 1112.592869] Call Trace:
[ 1112.592876]  update_srbds_msr+0x6f/0xb0
[ 1112.592880]  smp_store_cpu_info+0x8e/0xb0
[ 1112.592883]  start_secondary+0x93/0x200
[ 1112.592887]  ? set_cpu_sibling_map+0xcb0/0xcb0
[ 1112.592891]  secondary_startup_64+0xa4/0xb0
[ 1112.592898] unchecked MSR access error: WRMSR to 0x123 (tried to
write 0x0000000000000000) at rIP: 0xffffffffb5c9a264
(native_write_msr+0x4/0x20)
[ 1112.592899] Call Trace:
[ 1112.592902]  update_srbds_msr+0x98/0xb0
[ 1112.592904]  smp_store_cpu_info+0x8e/0xb0
[ 1112.592907]  start_secondary+0x93/0x200
[ 1112.592911]  ? set_cpu_sibling_map+0xcb0/0xcb0
[ 1112.592914]  secondary_startup_64+0xa4/0xb0
[ 2915.106879] show_signal: 6 callbacks suppressed
[ 6089.209343] WARNING: stack going in the wrong direction? at
i915_gem_close_object+0x2fb/0x560 [i915]
$
-----------------x---------------x----------------x------------
Linux debian 5.9.1-rc1+ #4 SMP Fri Oct 16 16:48:04 IST 2020 x86_64
GNU/Linux

GNU Make            	4.3
Binutils            	2.35.1
Util-linux          	2.36
Mount               	2.36
Bison               	3.7.2
Flex                	2.6.4
Dynamic linker (ldd)	2.30
Procps              	3.3.16
Kbd                 	2.3.0
Console-tools       	2.3.0
Sh-utils            	8.32
Udev                	246


Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in

--=20
software engineer
rajagiri school of engineering and technology
=0D
--=-+RigdPpNJraeUxG+DbEr
Content-Disposition: attachment; filename="meminfo.txt"
Content-Type: text/plain; name="meminfo.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

TWVtVG90YWw6ICAgICAgICA2OTUyNTc2IGtCCk1lbUZyZWU6ICAgICAgICAgIDI5OTAwMCBrQgpN
ZW1BdmFpbGFibGU6ICAgIDI5NjQ3NDgga0IKQnVmZmVyczogICAgICAgICAgMTY5MDI0IGtCCkNh
Y2hlZDogICAgICAgICAgMzQ0NzMzNiBrQgpTd2FwQ2FjaGVkOiAgICAgICAgICAxMDgga0IKQWN0
aXZlOiAgICAgICAgICAxOTk2MzU2IGtCCkluYWN0aXZlOiAgICAgICAgMzMxNTgyMCBrQgpBY3Rp
dmUoYW5vbik6ICAgICA2NDM3NDgga0IKSW5hY3RpdmUoYW5vbik6ICAxOTUwODkyIGtCCkFjdGl2
ZShmaWxlKTogICAgMTM1MjYwOCBrQgpJbmFjdGl2ZShmaWxlKTogIDEzNjQ5Mjgga0IKVW5ldmlj
dGFibGU6ICAgICAgIDU3NjY4IGtCCk1sb2NrZWQ6ICAgICAgICAgICAgIDE2MCBrQgpTd2FwVG90
YWw6ICAgICAgIDgyNjM2NzYga0IKU3dhcEZyZWU6ICAgICAgICA4MjYxMDkyIGtCCkRpcnR5OiAg
ICAgICAgICAgICAxNjYzMiBrQgpXcml0ZWJhY2s6ICAgICAgICAgICAgIDAga0IKQW5vblBhZ2Vz
OiAgICAgICAxNzM2NzcyIGtCCk1hcHBlZDogICAgICAgICAgIDUyMDU3MiBrQgpTaG1lbTogICAg
ICAgICAgICA4OTg3NjAga0IKS1JlY2xhaW1hYmxlOiAgICAgMjY0MDQ4IGtCClNsYWI6ICAgICAg
ICAgICAgMTA0NTk2OCBrQgpTUmVjbGFpbWFibGU6ICAgICAyNjQwNDgga0IKU1VucmVjbGFpbTog
ICAgICAgNzgxOTIwIGtCCktlcm5lbFN0YWNrOiAgICAgICAyODMyMCBrQgpQYWdlVGFibGVzOiAg
ICAgICAgMjc4NTYga0IKTkZTX1Vuc3RhYmxlOiAgICAgICAgICAwIGtCCkJvdW5jZTogICAgICAg
ICAgICAgICAgMCBrQgpXcml0ZWJhY2tUbXA6ICAgICAgICAgIDAga0IKQ29tbWl0TGltaXQ6ICAg
IDExNzM5OTY0IGtCCkNvbW1pdHRlZF9BUzogICAgNzc0MTg0OCBrQgpWbWFsbG9jVG90YWw6ICAg
MzQzNTk3MzgzNjcga0IKVm1hbGxvY1VzZWQ6ICAgICAgIDYwNTQ0IGtCClZtYWxsb2NDaHVuazog
ICAgICAgICAgMCBrQgpQZXJjcHU6ICAgICAgICAgICAgIDI2NzIga0IKSGFyZHdhcmVDb3JydXB0
ZWQ6ICAgICAwIGtCCkFub25IdWdlUGFnZXM6ICAgIDc2MzkwNCBrQgpTaG1lbUh1Z2VQYWdlczog
ICAgICAgIDAga0IKU2htZW1QbWRNYXBwZWQ6ICAgICAgICAwIGtCCkZpbGVIdWdlUGFnZXM6ICAg
ICAgICAgMCBrQgpGaWxlUG1kTWFwcGVkOiAgICAgICAgIDAga0IKSHVnZVBhZ2VzX1RvdGFsOiAg
ICAgICAwCkh1Z2VQYWdlc19GcmVlOiAgICAgICAgMApIdWdlUGFnZXNfUnN2ZDogICAgICAgIDAK
SHVnZVBhZ2VzX1N1cnA6ICAgICAgICAwCkh1Z2VwYWdlc2l6ZTogICAgICAgMjA0OCBrQgpIdWdl
dGxiOiAgICAgICAgICAgICAgIDAga0IKRGlyZWN0TWFwNGs6ICAgICAgODkxNzU2IGtCCkRpcmVj
dE1hcDJNOiAgICAgNzM3MjgwMCBrQgpEaXJlY3RNYXAxRzogICAgIDEwNDg1NzYga0IK


--=-+RigdPpNJraeUxG+DbEr
Content-Disposition: attachment; filename="lscpu.txt"
Content-Type: text/plain; name="lscpu.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

QXJjaGl0ZWN0dXJlOiAgICAgICAgICAgICAgICAgICAgeDg2XzY0CkNQVSBvcC1tb2RlKHMpOiAg
ICAgICAgICAgICAgICAgIDMyLWJpdCwgNjQtYml0CkJ5dGUgT3JkZXI6ICAgICAgICAgICAgICAg
ICAgICAgIExpdHRsZSBFbmRpYW4KQWRkcmVzcyBzaXplczogICAgICAgICAgICAgICAgICAgMzkg
Yml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCkNQVShzKTogICAgICAgICAgICAgICAgICAg
ICAgICAgIDQKT24tbGluZSBDUFUocykgbGlzdDogICAgICAgICAgICAgMC0zClRocmVhZChzKSBw
ZXIgY29yZTogICAgICAgICAgICAgIDIKQ29yZShzKSBwZXIgc29ja2V0OiAgICAgICAgICAgICAg
MgpTb2NrZXQocyk6ICAgICAgICAgICAgICAgICAgICAgICAxCk5VTUEgbm9kZShzKTogICAgICAg
ICAgICAgICAgICAgIDEKVmVuZG9yIElEOiAgICAgICAgICAgICAgICAgICAgICAgR2VudWluZUlu
dGVsCkNQVSBmYW1pbHk6ICAgICAgICAgICAgICAgICAgICAgIDYKTW9kZWw6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMTQyCk1vZGVsIG5hbWU6ICAgICAgICAgICAgICAgICAgICAgIEludGVs
KFIpIENvcmUoVE0pIGkzLTcwMjBVIENQVSBAIDIuMzBHSHoKU3RlcHBpbmc6ICAgICAgICAgICAg
ICAgICAgICAgICAgOQpDUFUgTUh6OiAgICAgICAgICAgICAgICAgICAgICAgICAyMjk5Ljk5OQpD
UFUgbWF4IE1IejogICAgICAgICAgICAgICAgICAgICAyMzAwLjAwMDAKQ1BVIG1pbiBNSHo6ICAg
ICAgICAgICAgICAgICAgICAgNDAwLjAwMDAKQm9nb01JUFM6ICAgICAgICAgICAgICAgICAgICAg
ICAgNDU5OS45MwpWaXJ0dWFsaXphdGlvbjogICAgICAgICAgICAgICAgICBWVC14CkwxZCBjYWNo
ZTogICAgICAgICAgICAgICAgICAgICAgIDY0IEtpQgpMMWkgY2FjaGU6ICAgICAgICAgICAgICAg
ICAgICAgICA2NCBLaUIKTDIgY2FjaGU6ICAgICAgICAgICAgICAgICAgICAgICAgNTEyIEtpQgpM
MyBjYWNoZTogICAgICAgICAgICAgICAgICAgICAgICAzIE1pQgpOVU1BIG5vZGUwIENQVShzKTog
ICAgICAgICAgICAgICAwLTMKVnVsbmVyYWJpbGl0eSBJdGxiIG11bHRpaGl0OiAgICAgS1ZNOiBN
aXRpZ2F0aW9uOiBWTVggZGlzYWJsZWQKVnVsbmVyYWJpbGl0eSBMMXRmOiAgICAgICAgICAgICAg
TWl0aWdhdGlvbjsgUFRFIEludmVyc2lvbjsgVk1YIGNvbmRpdGlvbmFsIGNhY2hlIGZsdXNoZXMs
IFNNVCB2dWxuZXJhYmxlClZ1bG5lcmFiaWxpdHkgTWRzOiAgICAgICAgICAgICAgIE1pdGlnYXRp
b247IENsZWFyIENQVSBidWZmZXJzOyBTTVQgdnVsbmVyYWJsZQpWdWxuZXJhYmlsaXR5IE1lbHRk
b3duOiAgICAgICAgICBNaXRpZ2F0aW9uOyBQVEkKVnVsbmVyYWJpbGl0eSBTcGVjIHN0b3JlIGJ5
cGFzczogTWl0aWdhdGlvbjsgU3BlY3VsYXRpdmUgU3RvcmUgQnlwYXNzIGRpc2FibGVkIHZpYSBw
cmN0bCBhbmQgc2VjY29tcApWdWxuZXJhYmlsaXR5IFNwZWN0cmUgdjE6ICAgICAgICBNaXRpZ2F0
aW9uOyB1c2VyY29weS9zd2FwZ3MgYmFycmllcnMgYW5kIF9fdXNlciBwb2ludGVyIHNhbml0aXph
dGlvbgpWdWxuZXJhYmlsaXR5IFNwZWN0cmUgdjI6ICAgICAgICBNaXRpZ2F0aW9uOyBGdWxsIGdl
bmVyaWMgcmV0cG9saW5lLCBJQlBCIGNvbmRpdGlvbmFsLCBJQlJTX0ZXLCBTVElCUCBjb25kaXRp
b25hbCwgUlNCIGZpbGxpbmcKVnVsbmVyYWJpbGl0eSBTcmJkczogICAgICAgICAgICAgTWl0aWdh
dGlvbjsgTWljcm9jb2RlClZ1bG5lcmFiaWxpdHkgVHN4IGFzeW5jIGFib3J0OiAgIE5vdCBhZmZl
Y3RlZApGbGFnczogICAgICAgICAgICAgICAgICAgICAgICAgICBmcHUgdm1lIGRlIHBzZSB0c2Mg
bXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jYSBjbW92IHBhdCBwc2UzNiBjbGZs
dXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2UyIHNzIGh0IHRtIHBiZSBzeXNjYWxsIG54IHBk
cGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBhcnQgYXJjaF9wZXJmbW9uIHBlYnMgYnRzIHJl
cF9nb29kIG5vcGwgeHRvcG9sb2d5IG5vbnN0b3BfdHNjIGNwdWlkIGFwZXJmbXBlcmYgcG5pIHBj
bG11bHFkcSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14IGVzdCB0bTIgc3NzZTMgc2RiZyBmbWEg
Y3gxNiB4dHByIHBkY20gcGNpZCBzc2U0XzEgc3NlNF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNj
X2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2ZSBhdnggZjE2YyByZHJhbmQgbGFoZl9sbSBhYm0gM2Ru
b3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBlcGIgaW52cGNpZF9zaW5nbGUgcHRpIHNzYmQgaWJycyBp
YnBiIHN0aWJwIHRwcl9zaGFkb3cgdm5taSBmbGV4cHJpb3JpdHkgZXB0IHZwaWQgZXB0X2FkIGZz
Z3NiYXNlIHRzY19hZGp1c3QgYm1pMSBhdngyIHNtZXAgYm1pMiBlcm1zIGludnBjaWQgbXB4IHJk
c2VlZCBhZHggc21hcCBjbGZsdXNob3B0IGludGVsX3B0IHhzYXZlb3B0IHhzYXZlYyB4Z2V0YnYx
IHhzYXZlcyBkdGhlcm0gYXJhdCBwbG4gcHRzIGh3cCBod3Bfbm90aWZ5IGh3cF9hY3Rfd2luZG93
IGh3cF9lcHAgbWRfY2xlYXIgZmx1c2hfbDFkCg==


--=-+RigdPpNJraeUxG+DbEr--


--=-xDbNw6FXGP/quuFNhvZj
Content-Disposition: attachment; filename="meminfo.txt"
Content-Type: text/plain; name="meminfo.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

TWVtVG90YWw6ICAgICAgICA2OTUyNTc2IGtCCk1lbUZyZWU6ICAgICAgICAgIDI5OTAwMCBrQgpN
ZW1BdmFpbGFibGU6ICAgIDI5NjQ3NDgga0IKQnVmZmVyczogICAgICAgICAgMTY5MDI0IGtCCkNh
Y2hlZDogICAgICAgICAgMzQ0NzMzNiBrQgpTd2FwQ2FjaGVkOiAgICAgICAgICAxMDgga0IKQWN0
aXZlOiAgICAgICAgICAxOTk2MzU2IGtCCkluYWN0aXZlOiAgICAgICAgMzMxNTgyMCBrQgpBY3Rp
dmUoYW5vbik6ICAgICA2NDM3NDgga0IKSW5hY3RpdmUoYW5vbik6ICAxOTUwODkyIGtCCkFjdGl2
ZShmaWxlKTogICAgMTM1MjYwOCBrQgpJbmFjdGl2ZShmaWxlKTogIDEzNjQ5Mjgga0IKVW5ldmlj
dGFibGU6ICAgICAgIDU3NjY4IGtCCk1sb2NrZWQ6ICAgICAgICAgICAgIDE2MCBrQgpTd2FwVG90
YWw6ICAgICAgIDgyNjM2NzYga0IKU3dhcEZyZWU6ICAgICAgICA4MjYxMDkyIGtCCkRpcnR5OiAg
ICAgICAgICAgICAxNjYzMiBrQgpXcml0ZWJhY2s6ICAgICAgICAgICAgIDAga0IKQW5vblBhZ2Vz
OiAgICAgICAxNzM2NzcyIGtCCk1hcHBlZDogICAgICAgICAgIDUyMDU3MiBrQgpTaG1lbTogICAg
ICAgICAgICA4OTg3NjAga0IKS1JlY2xhaW1hYmxlOiAgICAgMjY0MDQ4IGtCClNsYWI6ICAgICAg
ICAgICAgMTA0NTk2OCBrQgpTUmVjbGFpbWFibGU6ICAgICAyNjQwNDgga0IKU1VucmVjbGFpbTog
ICAgICAgNzgxOTIwIGtCCktlcm5lbFN0YWNrOiAgICAgICAyODMyMCBrQgpQYWdlVGFibGVzOiAg
ICAgICAgMjc4NTYga0IKTkZTX1Vuc3RhYmxlOiAgICAgICAgICAwIGtCCkJvdW5jZTogICAgICAg
ICAgICAgICAgMCBrQgpXcml0ZWJhY2tUbXA6ICAgICAgICAgIDAga0IKQ29tbWl0TGltaXQ6ICAg
IDExNzM5OTY0IGtCCkNvbW1pdHRlZF9BUzogICAgNzc0MTg0OCBrQgpWbWFsbG9jVG90YWw6ICAg
MzQzNTk3MzgzNjcga0IKVm1hbGxvY1VzZWQ6ICAgICAgIDYwNTQ0IGtCClZtYWxsb2NDaHVuazog
ICAgICAgICAgMCBrQgpQZXJjcHU6ICAgICAgICAgICAgIDI2NzIga0IKSGFyZHdhcmVDb3JydXB0
ZWQ6ICAgICAwIGtCCkFub25IdWdlUGFnZXM6ICAgIDc2MzkwNCBrQgpTaG1lbUh1Z2VQYWdlczog
ICAgICAgIDAga0IKU2htZW1QbWRNYXBwZWQ6ICAgICAgICAwIGtCCkZpbGVIdWdlUGFnZXM6ICAg
ICAgICAgMCBrQgpGaWxlUG1kTWFwcGVkOiAgICAgICAgIDAga0IKSHVnZVBhZ2VzX1RvdGFsOiAg
ICAgICAwCkh1Z2VQYWdlc19GcmVlOiAgICAgICAgMApIdWdlUGFnZXNfUnN2ZDogICAgICAgIDAK
SHVnZVBhZ2VzX1N1cnA6ICAgICAgICAwCkh1Z2VwYWdlc2l6ZTogICAgICAgMjA0OCBrQgpIdWdl
dGxiOiAgICAgICAgICAgICAgIDAga0IKRGlyZWN0TWFwNGs6ICAgICAgODkxNzU2IGtCCkRpcmVj
dE1hcDJNOiAgICAgNzM3MjgwMCBrQgpEaXJlY3RNYXAxRzogICAgIDEwNDg1NzYga0IK


--=-xDbNw6FXGP/quuFNhvZj
Content-Disposition: attachment; filename="lscpu.txt"
Content-Type: text/plain; name="lscpu.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

QXJjaGl0ZWN0dXJlOiAgICAgICAgICAgICAgICAgICAgeDg2XzY0CkNQVSBvcC1tb2RlKHMpOiAg
ICAgICAgICAgICAgICAgIDMyLWJpdCwgNjQtYml0CkJ5dGUgT3JkZXI6ICAgICAgICAgICAgICAg
ICAgICAgIExpdHRsZSBFbmRpYW4KQWRkcmVzcyBzaXplczogICAgICAgICAgICAgICAgICAgMzkg
Yml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCkNQVShzKTogICAgICAgICAgICAgICAgICAg
ICAgICAgIDQKT24tbGluZSBDUFUocykgbGlzdDogICAgICAgICAgICAgMC0zClRocmVhZChzKSBw
ZXIgY29yZTogICAgICAgICAgICAgIDIKQ29yZShzKSBwZXIgc29ja2V0OiAgICAgICAgICAgICAg
MgpTb2NrZXQocyk6ICAgICAgICAgICAgICAgICAgICAgICAxCk5VTUEgbm9kZShzKTogICAgICAg
ICAgICAgICAgICAgIDEKVmVuZG9yIElEOiAgICAgICAgICAgICAgICAgICAgICAgR2VudWluZUlu
dGVsCkNQVSBmYW1pbHk6ICAgICAgICAgICAgICAgICAgICAgIDYKTW9kZWw6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMTQyCk1vZGVsIG5hbWU6ICAgICAgICAgICAgICAgICAgICAgIEludGVs
KFIpIENvcmUoVE0pIGkzLTcwMjBVIENQVSBAIDIuMzBHSHoKU3RlcHBpbmc6ICAgICAgICAgICAg
ICAgICAgICAgICAgOQpDUFUgTUh6OiAgICAgICAgICAgICAgICAgICAgICAgICAyMjk5Ljk5OQpD
UFUgbWF4IE1IejogICAgICAgICAgICAgICAgICAgICAyMzAwLjAwMDAKQ1BVIG1pbiBNSHo6ICAg
ICAgICAgICAgICAgICAgICAgNDAwLjAwMDAKQm9nb01JUFM6ICAgICAgICAgICAgICAgICAgICAg
ICAgNDU5OS45MwpWaXJ0dWFsaXphdGlvbjogICAgICAgICAgICAgICAgICBWVC14CkwxZCBjYWNo
ZTogICAgICAgICAgICAgICAgICAgICAgIDY0IEtpQgpMMWkgY2FjaGU6ICAgICAgICAgICAgICAg
ICAgICAgICA2NCBLaUIKTDIgY2FjaGU6ICAgICAgICAgICAgICAgICAgICAgICAgNTEyIEtpQgpM
MyBjYWNoZTogICAgICAgICAgICAgICAgICAgICAgICAzIE1pQgpOVU1BIG5vZGUwIENQVShzKTog
ICAgICAgICAgICAgICAwLTMKVnVsbmVyYWJpbGl0eSBJdGxiIG11bHRpaGl0OiAgICAgS1ZNOiBN
aXRpZ2F0aW9uOiBWTVggZGlzYWJsZWQKVnVsbmVyYWJpbGl0eSBMMXRmOiAgICAgICAgICAgICAg
TWl0aWdhdGlvbjsgUFRFIEludmVyc2lvbjsgVk1YIGNvbmRpdGlvbmFsIGNhY2hlIGZsdXNoZXMs
IFNNVCB2dWxuZXJhYmxlClZ1bG5lcmFiaWxpdHkgTWRzOiAgICAgICAgICAgICAgIE1pdGlnYXRp
b247IENsZWFyIENQVSBidWZmZXJzOyBTTVQgdnVsbmVyYWJsZQpWdWxuZXJhYmlsaXR5IE1lbHRk
b3duOiAgICAgICAgICBNaXRpZ2F0aW9uOyBQVEkKVnVsbmVyYWJpbGl0eSBTcGVjIHN0b3JlIGJ5
cGFzczogTWl0aWdhdGlvbjsgU3BlY3VsYXRpdmUgU3RvcmUgQnlwYXNzIGRpc2FibGVkIHZpYSBw
cmN0bCBhbmQgc2VjY29tcApWdWxuZXJhYmlsaXR5IFNwZWN0cmUgdjE6ICAgICAgICBNaXRpZ2F0
aW9uOyB1c2VyY29weS9zd2FwZ3MgYmFycmllcnMgYW5kIF9fdXNlciBwb2ludGVyIHNhbml0aXph
dGlvbgpWdWxuZXJhYmlsaXR5IFNwZWN0cmUgdjI6ICAgICAgICBNaXRpZ2F0aW9uOyBGdWxsIGdl
bmVyaWMgcmV0cG9saW5lLCBJQlBCIGNvbmRpdGlvbmFsLCBJQlJTX0ZXLCBTVElCUCBjb25kaXRp
b25hbCwgUlNCIGZpbGxpbmcKVnVsbmVyYWJpbGl0eSBTcmJkczogICAgICAgICAgICAgTWl0aWdh
dGlvbjsgTWljcm9jb2RlClZ1bG5lcmFiaWxpdHkgVHN4IGFzeW5jIGFib3J0OiAgIE5vdCBhZmZl
Y3RlZApGbGFnczogICAgICAgICAgICAgICAgICAgICAgICAgICBmcHUgdm1lIGRlIHBzZSB0c2Mg
bXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jYSBjbW92IHBhdCBwc2UzNiBjbGZs
dXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2UyIHNzIGh0IHRtIHBiZSBzeXNjYWxsIG54IHBk
cGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBhcnQgYXJjaF9wZXJmbW9uIHBlYnMgYnRzIHJl
cF9nb29kIG5vcGwgeHRvcG9sb2d5IG5vbnN0b3BfdHNjIGNwdWlkIGFwZXJmbXBlcmYgcG5pIHBj
bG11bHFkcSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14IGVzdCB0bTIgc3NzZTMgc2RiZyBmbWEg
Y3gxNiB4dHByIHBkY20gcGNpZCBzc2U0XzEgc3NlNF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNj
X2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2ZSBhdnggZjE2YyByZHJhbmQgbGFoZl9sbSBhYm0gM2Ru
b3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBlcGIgaW52cGNpZF9zaW5nbGUgcHRpIHNzYmQgaWJycyBp
YnBiIHN0aWJwIHRwcl9zaGFkb3cgdm5taSBmbGV4cHJpb3JpdHkgZXB0IHZwaWQgZXB0X2FkIGZz
Z3NiYXNlIHRzY19hZGp1c3QgYm1pMSBhdngyIHNtZXAgYm1pMiBlcm1zIGludnBjaWQgbXB4IHJk
c2VlZCBhZHggc21hcCBjbGZsdXNob3B0IGludGVsX3B0IHhzYXZlb3B0IHhzYXZlYyB4Z2V0YnYx
IHhzYXZlcyBkdGhlcm0gYXJhdCBwbG4gcHRzIGh3cCBod3Bfbm90aWZ5IGh3cF9hY3Rfd2luZG93
IGh3cF9lcHAgbWRfY2xlYXIgZmx1c2hfbDFkCg==


--=-xDbNw6FXGP/quuFNhvZj--

