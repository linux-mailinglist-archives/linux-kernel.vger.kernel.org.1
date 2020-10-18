Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D62917F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgJROyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJROym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 10:54:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20898C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 07:54:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id bf6so1679474plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version;
        bh=ii0kW+aXVbdGbqkg9+RQMpYW8+WDFwD4nmMA6+bDJtg=;
        b=eA69z4oFT1Kr45oHZucfbqf9Ahjk8N86kKtpQ4vl+XjPN2TLXnfozcDmRNQbr6zbO/
         ywmVExWtA8JcCE5duqUIdc1FthtmjnjIZC+kW8V6MlDVAYrGlybRVGFashNLnW6faZtt
         tIMWrTNocYmw2hiqKJ7w6gTG9EAN7fYh3nHP6D1rJ8Yfzlmlih5J30IFj5CSn31AwzXH
         9vmG+NPAzZkOx9OVPqgnUcqawSXM0BrKgKd+xiwq6MtcsHcFpkT6NKtQZh8tEJgSWKmX
         ww3pWd2nn37Cl6yggSWiBIV1OcKaYve++IqTkHUCAytPmlvQIGXihhD1xD59bGhLmP4H
         SiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version;
        bh=ii0kW+aXVbdGbqkg9+RQMpYW8+WDFwD4nmMA6+bDJtg=;
        b=ahrBV5vxFFYraRwipPS4SE5EubOyiOQZoYoFvdvOrRgwvTD3nmWPWrYfZEyn9cS+FJ
         N1zct+fYeLcEc1CMO1qoU2X5NSjM+3IXfh6i748xxqtgRmL2rHMYbpkmCRBfBrmw/JiH
         NRx1qXnGTSsYUqIWMeIH3GtbSNXLJMurWoV0/5PO+hhbMlKLjMIwG30LlcPk14UCd98u
         LfsL8mRVyiHWm6XvkznpTbxYS/TeJjjriBvDpjwWg+T6JRSeZQt+fCpalOFX0ODukZXc
         1uo6TPsswLWGNtwQBf/dbhIxrKEh+9ONr66K4bvP0aBssb/KC1rV0D1h9JgbDZfIgv1b
         NlOg==
X-Gm-Message-State: AOAM532GVzA3hnB2SDa6NF7/cYoOb0qJOtD+2oCmjByunELC24gzOhRg
        uUl7DaMJmRpqoMs4qzJyBA3vCybYfr0bwQ==
X-Google-Smtp-Source: ABdhPJzxZ8zWRneeXfhBiYz1FsRf6qmL2L6fecKIzYT6gJvJf7BKSyWbV9Nu2JFKGu9d4015AEOVuQ==
X-Received: by 2002:a17:902:8541:b029:d5:b4f3:314e with SMTP id d1-20020a1709028541b02900d5b4f3314emr13195128plo.31.1603032881152;
        Sun, 18 Oct 2020 07:54:41 -0700 (PDT)
Received: from debian ([122.183.152.57])
        by smtp.gmail.com with ESMTPSA id k78sm9332216pfd.194.2020.10.18.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 07:54:40 -0700 (PDT)
Message-ID: <959da1eee73f58a824fe4913b5cacda6de0f392e.camel@rajagiritech.edu.in>
Subject: [WARNING AND ERROR]  may be  system slow and  audio and video
 breaking
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Date:   Sun, 18 Oct 2020 20:24:36 +0530
Content-Type: multipart/mixed; boundary="=-+RigdPpNJraeUxG+DbEr"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+RigdPpNJraeUxG+DbEr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

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

-- 
software engineer
rajagiri school of engineering and technology

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

