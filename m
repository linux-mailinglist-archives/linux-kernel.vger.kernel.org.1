Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD126C1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIPK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgIPKSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:18:32 -0400
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Sep 2020 03:18:27 PDT
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [IPv6:2001:7c0:2041:24::a:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F72BC061788;
        Wed, 16 Sep 2020 03:18:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 604836028F;
        Wed, 16 Sep 2020 12:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
         h=content-language:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:from:from:subject
        :subject:references:received:received; s=dkim; i=
        @tik.uni-stuttgart.de; t=1600251139; x=1601989940; bh=9ERVM5TDeS
        8iRm2yD1A33RDO5LnIrGDG7pFzhLnJ+rM=; b=GC3Ej+8swElnIZee4r8NqlswXL
        Zn2HKAdf+SipOXlVnMeRLrXpzTfyGlj63WljJG3bVlSVamBZrrkPEzbES+W8SdDh
        bw/bwcgO068NiMN0Ag7XGaICGxfWq7imROUlHPQrXAU8WFeg3n/HOBGqmuG+02r6
        gwzxvSx3693k4lT/rpq79+ybTMxsk9BEz48ATpMlpD7h+4jQKqc9080YC3Z9OoH7
        TPiy+0AdzuRluTguiB43fVnJY4vJeS5pevs8VTjwB48k5EyOcwmTqe+13nEA1Aa7
        1a3OrSwct4ue4e8DePo4+OesNRykfppAwF16dv90EbhDyUJ2uhGCtboKz0MQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
        by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10031)
        with ESMTP id 9VKFfgFAQvtQ; Wed, 16 Sep 2020 12:12:19 +0200 (CEST)
Received: from [IPv6:2001:7c0:7c0:111:e9f5:5103:9fb5:8ce3] (unknown [IPv6:2001:7c0:7c0:111:e9f5:5103:9fb5:8ce3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA;
        Wed, 16 Sep 2020 12:12:18 +0200 (CEST)
To:     sean.v.kelley@linux.intel.com
Cc:     bhelgaas@google.com, bp@alien8.de, corbet@lwn.net,
        kar.hin.ong@ni.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mingo@redhat.com, sassmann@kpanic.de, tglx@linutronix.de,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200220192930.64820-1-sean.v.kelley@linux.intel.com>
Subject: boot interrupt quirk (also in 4.19.y) breaks serial ports (was:
 [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
From:   "=?UTF-8?Q?Stefan_B=c3=bchler?=" 
        <stefan.buehler@tik.uni-stuttgart.de>
Autocrypt: addr=stefan.buehler@tik.uni-stuttgart.de; prefer-encrypt=mutual;
 keydata=
 mQINBFqdUS0BEACwqBty1vfttUbrvQMqHL6OvsNEv6b+V/xZ+64NUNkJHJEjlDM/PxDniTfm
 HtsNgFVZDpY58SyHjZFU8VA7lf6HIJ3N2e0diBDdh+cd0MtwnK6D8ukSjpAupSnyQsglVgfa
 gmatuuu0C6OT4PHutYBlch4cNbJx5nljVm3bNBKWq4NaGht0NKTAyzg/fe3dg8e8AvbDX0S0
 eAtR3sWdecOelR+cTkCOPxR5SdfuIYkCS2T7ReBcQ7TDH/DsMfonUgxL+y+rac6bIlxDtDWw
 s8VIZ7Uzk6Vpdh2DpvY3riqNhEigo6/k95Px/tgVji1agASWQ7qid+uILj641CMM5xibVt0K
 wawSGxdb/PMQglvc4YdkAjpxb1TfuSmvsk3Pw8Gj+YjwbEAflgJj61Ol8SIraG7NjBZGPTmb
 qf7IS8dKhV4rK/61i6nJsOghswNNwXYZncSZlLAEmiySp9cFFmuAbWy9RgC+rPaBHzEf85hd
 UyLVHupv/gbOoIDlNIKkYukwW2y6TosQOcwyvfjHK4ElMGZhB8VjdEEIqFA+DVGzyHhajcqX
 kIu5/QoiQ6hiGI0z1xXTxqo6NQ7zQJnMlsNuyfh0yLCB7ox79S55IYExnlWnm9oL7muUsSez
 Raw9JHO9v0zVElhuc7Nbj+tWW5X9VD8Sg/d8kHKxZv17SB8OMQARAQABtDRTdGVmYW4gQsO8
 aGxlciA8c3RlZmFuLmJ1ZWhsZXJAdGlrLnVuaS1zdHV0dGdhcnQuZGU+iQJOBBMBCgA4FiEE
 cdms641aWv8vJSXMIcx4mUG+20gFAlqdUS0CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AA
 CgkQIcx4mUG+20hvwQ//Td19rtFeX3blbdQF6LExcl+/AOnA1GtEf3vfr4u+LOSkDYDqU8JE
 j2IrEZ1p1l7EF+A0DDgN1UkFEFNUsqS/NPEGHXnYNX4wjjz1iS6mlcWJh/wrdT4s2HZOi5IS
 gUMGch10cC87iWC5ld1jzGOKrnehcWfNOGNrSN1rwVnnlPXowkCkFKDKczjD7KFThmLd9/aR
 vl+72vnDRnh+7ZgKsIva7WFYzvZ3uhNpiG9CUkcSD/uUOxaaL89dsY118tlKRWsJ2SFSeRKo
 4b6/pkyZPhMG3SjIjeRLprYIoaD7JAiml1jEfiDTQY5vdfHcX/ahGdE870R75j/S2xyy3X1F
 bFIk+4CHJ37QoMkw9ENskCfqdHMdA64rmvYa5CmlyKil4h49UDnWuCHE6E6dqUdsCpvTpI6u
 gh3PxWa4O8mYNXTVfeke7hAPIKyV7tVcFmPyZ66hTPST47RZm/czM4qn0rJH/N/6dPVHV775
 o25YwMpvtAjsA2oX/IZ5uDFqNbNFn9dNSocUKA/3sld+z0g6egyQgkLf5NrwG8RZe/UUwA5j
 d7d1rsBGUdCteUaZ1OOSOsOrPYfZNEYRCo0wRnvgek4nXLK36bfB5noLba/vuf6inv18Y/Oa
 Ui3bhvxoMgNyNNHblccG5YAe5PC/M371gy7mHkPh6QxnagzwvarTCya5Ag0EWp1RLQEQANHW
 L4TDHno6VDi2klvp96N7J7efZHWdKVnqhMf7gLXdogGahDrQPH+cz33u3fUZKxDdF8dPebq9
 s7g+rPypcMTKrvJ0ak6sOKyi1KTCDTYSJQRJY/LHq2XiIt8Wz+WpVPErBItVmZdLS3RoZkqT
 9cH9bQcm9wj9gYV7IP5EaDI/kHSpAPNTVi6BOXWUZhDDQsHplP9CN/nEim8/ATjI39WIFy3B
 BdUl2P3kvK7dIHKH2VYngdtH76Hs2xvV82DSdlUes8/dm1Tz9QzZXvuxtACS49LfWFSkqswO
 hyX2QYyQs7+2IqeBMy2nGeNeH+2c05gev6oP4S0M44rfQeFXkMLXQD3q4ZgiRcQSk1TOier1
 7Yy8GjrpUhLdE6aMmXczKZrbFa25KTeDJh97rm1wThZTbyiiLemvN9t67Njrr8mb/zr1XOPm
 UhIBu6ucmwbvsv6yIhYRfWqotx/HjZHB3wX33FmEAzPQL3NtvD8wQjJBtJvh2ArHiM7P/PNw
 Ogdf45cD7m2ewv65wBcHC+Dkj9mdriQQFBkyGcDxOSrIriRx4KDWgLCL5o1EDsOqQFKXdSMG
 zEbo8ImKRhjUaRY4ixj6c8UffAD+n5g9chCMK+1PTAAs9xd4W9V6/PSODJuFjc9XOsKQKDaD
 9yi0oR3xYKjih9yNKcdKInoft+WpAWLXABEBAAGJAjYEGAEKACAWIQRx2azrjVpa/y8lJcwh
 zHiZQb7bSAUCWp1RLQIbDAAKCRAhzHiZQb7bSMuRD/4rnHMVnZNOjdRBp/pztxp2LKXCnonX
 z9znnmi93ltuTVFnqw1fxmAl5cpMd44ZoiiuZXse5v6fwL4QEPfVj7tctKnOk3UpKkGel/tL
 5pwyHHwMJCrVIgEMrBqM4HhtMtlawN8UdE8tzsPIq2U+vHq5+rK1Bcs6Ib6ug5VBxO4BC06I
 jwa/WoHUGFdTKHLoKGcKZt3K9q4BTU7gvM98ViPmtQkxddpuymnf42W6AVm/mh10tZDZ/N7J
 4tI+1mC6yD8OUFqvpPupqprJ8Lf4TxGtUcxE4GAqjvcLD7pagJD/6kz4rrJ8wXOu8pSuAJsl
 RlR9T5u88wYD6aqxbgCQUS1oD0+iRCjQ8SX3g3+KRThJIRf32SPw5Bjlao7UzTLmWRt/bYhD
 uBXm7ILMUkrHCe9+wPy6W/ZbxdRmDV3+gpz8mWrcSkHGjSk91UxMoM8JCDgjozV0+CTAnCTx
 bmQkmAEmgYbnykcsb2PLXFK+tOyldl88vbtfewqpJjzrHI3B2FFwzPv+hK0O6wzO+5CVCzFf
 miRYWRlOViu5OW92v5DtvG3imJsejFFbMhJJuGWznXE1GmXcdUJt4Vmde3rhs9of/IKvgHqK
 f2tjby0Ay8hEBjAsQXKs58U37gQOc7eqPsI3+i3bcAAIek+zfO+gaLf+Ur8bRTzORDmSCvWc
 rwHRmQ==
Message-ID: <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de>
Date:   Wed, 16 Sep 2020 12:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200220192930.64820-1-sean.v.kelley@linux.intel.com>
Content-Type: multipart/mixed;
 boundary="------------F39048ABA6B92B1707D476FE"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F39048ABA6B92B1707D476FE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

this quirk breaks our serial ports PCIe card (i.e. we don't see any 
output from the connected devices; no idea whether anything we send 
reaches them):

05:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa)
06:00.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (Uart)
06:00.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (Disabled)
06:01.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (Uart)
06:01.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (Disabled)

The hardware is "MP8-PCIe-RS232-R2" (we also have the 16-port variant) 
from https://rs-232.de/sercom_e.htm#MP8PCIERS232

The CPU is an "Intel(R) Xeon(R) CPU D-1518 @ 2.20GHz".

Disabling the quirk for 0x6f28 (Xeon D-1500) on 4.19.145 gets the serial 
ports working again (patch attached for reference).

The box is running debian stable; we build ixgbe 5.6.1 through dkms 
(local package) due to issues with the SFP+ ports (usually our 
uplink...).

Known broken versions: 4.19.115-00065, 4.19.118, 4.19.145, 5.8.9
Known good versions: 4.19.115-00064

Basically if we see "kernel: pci 0000:00:05.0: disabled boot interrupts 
on device [8086:6f28]" in the kernel log it's broken.

Attached lspci, lscpu, lsmod and kernel log outputs while running 5.8.9.

Can we disable the quirk somehow via the kernel commandline?

Anything else I can do to help getting this fixed properly?

(We have the same card in other boxes with CPUs not affected by this 
quirk; they are working just fine.)

cheers,
Stefan

-- 
Stefan Bühler    Mail/xmpp: stefan.buehler@tik.uni-stuttgart.de
Netze und Kommunikationssysteme der Universität Stuttgart (NKS)
https://www.tik.uni-stuttgart.de/    Telefon: +49 711 685 60854

--------------F39048ABA6B92B1707D476FE
Content-Type: text/plain; charset=UTF-8;
 name="lspci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lspci.txt"

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9u
IEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIERNSTIgKHJldiAwMykKMDA6MDEuMCBQQ0kgYnJp
ZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2
NC9YZW9uIEQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDEgKHJldiAwMykKMDA6MDEuMSBQQ0kg
YnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBF
MyB2NC9YZW9uIEQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDEgKHJldiAwMykKMDA6MDIuMCBQ
Q0kgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVv
biBFMyB2NC9YZW9uIEQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDIgKHJldiAwMykKMDA6MDIu
MiBQQ0kgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQv
WGVvbiBFMyB2NC9YZW9uIEQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDIgKHJldiAwMykKMDA6
MDMuMCBQQ0kgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUg
djQvWGVvbiBFMyB2NC9YZW9uIEQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDMgKHJldiAwMykK
MDA6MDMuMiBQQ0kgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24g
RTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDMgKHJldiAw
MykKMDA6MDUuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBF
NyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIE1hcC9WVGRfTWlzYy9TeXN0ZW0g
TWFuYWdlbWVudCAocmV2IDAzKQowMDowNS4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBD
b3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgSUlP
IEhvdCBQbHVnIChyZXYgMDMpCjAwOjA1LjIgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENv
cnBvcmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hlb24gRCBJSU8g
UkFTL0NvbnRyb2wgU3RhdHVzL0dsb2JhbCBFcnJvcnMgKHJldiAwMykKMDA6MTQuMCBVU0Ig
Y29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gOCBTZXJpZXMvQzIyMCBTZXJpZXMgQ2hp
cHNldCBGYW1pbHkgVVNCIHhIQ0kgKHJldiAwNSkKMDA6MTYuMCBDb21tdW5pY2F0aW9uIGNv
bnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDggU2VyaWVzL0MyMjAgU2VyaWVzIENoaXBz
ZXQgRmFtaWx5IE1FSSBDb250cm9sbGVyICMxIChyZXYgMDQpCjAwOjE2LjEgQ29tbXVuaWNh
dGlvbiBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4IFNlcmllcy9DMjIwIFNlcmll
cyBDaGlwc2V0IEZhbWlseSBNRUkgQ29udHJvbGxlciAjMiAocmV2IDA0KQowMDoxYS4wIFVT
QiBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4IFNlcmllcy9DMjIwIFNlcmllcyBD
aGlwc2V0IEZhbWlseSBVU0IgRUhDSSAjMiAocmV2IDA1KQowMDoxYy4wIFBDSSBicmlkZ2U6
IEludGVsIENvcnBvcmF0aW9uIDggU2VyaWVzL0MyMjAgU2VyaWVzIENoaXBzZXQgRmFtaWx5
IFBDSSBFeHByZXNzIFJvb3QgUG9ydCAjMSAocmV2IGQ1KQowMDoxYy4xIFBDSSBicmlkZ2U6
IEludGVsIENvcnBvcmF0aW9uIDggU2VyaWVzL0MyMjAgU2VyaWVzIENoaXBzZXQgRmFtaWx5
IFBDSSBFeHByZXNzIFJvb3QgUG9ydCAjMiAocmV2IGQ1KQowMDoxYy4zIFBDSSBicmlkZ2U6
IEludGVsIENvcnBvcmF0aW9uIDggU2VyaWVzL0MyMjAgU2VyaWVzIENoaXBzZXQgRmFtaWx5
IFBDSSBFeHByZXNzIFJvb3QgUG9ydCAjNCAocmV2IGQ1KQowMDoxYy40IFBDSSBicmlkZ2U6
IEludGVsIENvcnBvcmF0aW9uIDggU2VyaWVzL0MyMjAgU2VyaWVzIENoaXBzZXQgRmFtaWx5
IFBDSSBFeHByZXNzIFJvb3QgUG9ydCAjNSAocmV2IGQ1KQowMDoxZC4wIFVTQiBjb250cm9s
bGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4IFNlcmllcy9DMjIwIFNlcmllcyBDaGlwc2V0IEZh
bWlseSBVU0IgRUhDSSAjMSAocmV2IDA1KQowMDoxZi4wIElTQSBicmlkZ2U6IEludGVsIENv
cnBvcmF0aW9uIEMyMjQgU2VyaWVzIENoaXBzZXQgRmFtaWx5IFNlcnZlciBTdGFuZGFyZCBT
S1UgTFBDIENvbnRyb2xsZXIgKHJldiAwNSkKMDA6MWYuMyBTTUJ1czogSW50ZWwgQ29ycG9y
YXRpb24gOCBTZXJpZXMvQzIyMCBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgU01CdXMgQ29udHJv
bGxlciAocmV2IDA1KQowMDoxZi42IFNpZ25hbCBwcm9jZXNzaW5nIGNvbnRyb2xsZXI6IElu
dGVsIENvcnBvcmF0aW9uIDggU2VyaWVzIENoaXBzZXQgRmFtaWx5IFRoZXJtYWwgTWFuYWdl
bWVudCBDb250cm9sbGVyIChyZXYgMDUpCjAxOjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBj
b250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBTU0QgNjAwUCBTZXJpZXMgKHJldiAwMykK
MDM6MDAuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBQcm9j
ZXNzb3IgRCBGYW1pbHkgUXVpY2tEYXRhIFRlY2hub2xvZ3kgUmVnaXN0ZXIgRE1BIENoYW5u
ZWwgMAowMzowMC4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9u
IFByb2Nlc3NvciBEIEZhbWlseSBRdWlja0RhdGEgVGVjaG5vbG9neSBSZWdpc3RlciBETUEg
Q2hhbm5lbCAxCjAzOjAwLjIgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9u
IFhlb24gUHJvY2Vzc29yIEQgRmFtaWx5IFF1aWNrRGF0YSBUZWNobm9sb2d5IFJlZ2lzdGVy
IERNQSBDaGFubmVsIDIKMDM6MDAuMyBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9y
YXRpb24gWGVvbiBQcm9jZXNzb3IgRCBGYW1pbHkgUXVpY2tEYXRhIFRlY2hub2xvZ3kgUmVn
aXN0ZXIgRE1BIENoYW5uZWwgMwowNDowMC4wIEV0aGVybmV0IGNvbnRyb2xsZXI6IEludGVs
IENvcnBvcmF0aW9uIEV0aGVybmV0IENvbm5lY3Rpb24gWDU1MiAxMCBHYkUgU0ZQKwowNDow
MC4xIEV0aGVybmV0IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIEV0aGVybmV0IENv
bm5lY3Rpb24gWDU1MiAxMCBHYkUgU0ZQKwowNTowMC4wIFBDSSBicmlkZ2U6IFBMWCBUZWNo
bm9sb2d5LCBJbmMuIFBFWDgxMTIgeDEgTGFuZSBQQ0kgRXhwcmVzcy10by1QQ0kgQnJpZGdl
IChyZXYgYWEpCjA2OjAwLjAgU2VyaWFsIGNvbnRyb2xsZXI6IE94Zm9yZCBTZW1pY29uZHVj
dG9yIEx0ZCBPWDE2UENJOTU0IChRdWFkIDE2OTUwIFVBUlQpIGZ1bmN0aW9uIDAgKFVhcnQp
CjA2OjAwLjEgQnJpZGdlOiBPeGZvcmQgU2VtaWNvbmR1Y3RvciBMdGQgT1gxNlBDSTk1NCAo
UXVhZCAxNjk1MCBVQVJUKSBmdW5jdGlvbiAwIChEaXNhYmxlZCkKMDY6MDEuMCBTZXJpYWwg
Y29udHJvbGxlcjogT3hmb3JkIFNlbWljb25kdWN0b3IgTHRkIE9YMTZQQ0k5NTQgKFF1YWQg
MTY5NTAgVUFSVCkgZnVuY3Rpb24gMCAoVWFydCkKMDY6MDEuMSBCcmlkZ2U6IE94Zm9yZCBT
ZW1pY29uZHVjdG9yIEx0ZCBPWDE2UENJOTU0IChRdWFkIDE2OTUwIFVBUlQpIGZ1bmN0aW9u
IDAgKERpc2FibGVkKQowODowMC4wIEV0aGVybmV0IGNvbnRyb2xsZXI6IEludGVsIENvcnBv
cmF0aW9uIEkyMTAgR2lnYWJpdCBOZXR3b3JrIENvbm5lY3Rpb24gKHJldiAwMykKMDk6MDAu
MCBFdGhlcm5ldCBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBJMjEwIEdpZ2FiaXQg
TmV0d29yayBDb25uZWN0aW9uIChyZXYgMDMpCjBhOjAwLjAgUENJIGJyaWRnZTogQVNQRUVE
IFRlY2hub2xvZ3ksIEluYy4gQVNUMTE1MCBQQ0ktdG8tUENJIEJyaWRnZSAocmV2IDAzKQow
YjowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEFTUEVFRCBUZWNobm9sb2d5LCBJ
bmMuIEFTUEVFRCBHcmFwaGljcyBGYW1pbHkgKHJldiAzMCkKMGM6MDAuMCBFdGhlcm5ldCBj
b250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBJMzUwIEdpZ2FiaXQgTmV0d29yayBDb25u
ZWN0aW9uIChyZXYgMDEpCjBjOjAwLjEgRXRoZXJuZXQgY29udHJvbGxlcjogSW50ZWwgQ29y
cG9yYXRpb24gSTM1MCBHaWdhYml0IE5ldHdvcmsgQ29ubmVjdGlvbiAocmV2IDAxKQowYzow
MC4yIEV0aGVybmV0IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIEkzNTAgR2lnYWJp
dCBOZXR3b3JrIENvbm5lY3Rpb24gKHJldiAwMSkKMGM6MDAuMyBFdGhlcm5ldCBjb250cm9s
bGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBJMzUwIEdpZ2FiaXQgTmV0d29yayBDb25uZWN0aW9u
IChyZXYgMDEpCmZmOjBiLjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9u
IFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hlb24gRCBSMyBRUEkgTGluayAw
LzEgKHJldiAwMykKZmY6MGIuMSBQZXJmb3JtYW5jZSBjb3VudGVyczogSW50ZWwgQ29ycG9y
YXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIFIzIFFQSSBM
aW5rIDAvMSAocmV2IDAzKQpmZjowYi4yIFBlcmZvcm1hbmNlIGNvdW50ZXJzOiBJbnRlbCBD
b3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgUjMg
UVBJIExpbmsgMC8xIChyZXYgMDMpCmZmOjBiLjMgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVs
IENvcnBvcmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hlb24gRCBS
MyBRUEkgTGluayBEZWJ1ZyAocmV2IDAzKQpmZjowYy4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgQ2FjaGluZyBBZ2VudCAocmV2IDAzKQpmZjowYy4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgQ2FjaGluZyBBZ2VudCAocmV2IDAzKQpmZjowYy4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgQ2FjaGluZyBBZ2VudCAocmV2IDAzKQpmZjowYy4zIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgQ2FjaGluZyBBZ2VudCAocmV2IDAzKQpmZjowZi4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgQ2FjaGluZyBBZ2VudCAocmV2IDAzKQpmZjowZi40IFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgQ2FjaGluZyBBZ2VudCAocmV2IDAzKQpmZjowZi41IFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgQ2FjaGluZyBBZ2VudCAocmV2IDAzKQpmZjowZi42IFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgQ2FjaGluZyBBZ2VudCAocmV2IDAzKQpmZjoxMC4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgUjJQQ0llIEFnZW50IChyZXYgMDMpCmZmOjEwLjEgUGVyZm9ybWFuY2UgY291bnRlcnM6
IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hl
b24gRCBSMlBDSWUgQWdlbnQgKHJldiAwMykKZmY6MTAuNSBTeXN0ZW0gcGVyaXBoZXJhbDog
SW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVv
biBEIFVib3ggKHJldiAwMykKZmY6MTAuNiBQZXJmb3JtYW5jZSBjb3VudGVyczogSW50ZWwg
Q29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIFVi
b3ggKHJldiAwMykKZmY6MTAuNyBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRp
b24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIFVib3ggKHJldiAw
MykKZmY6MTIuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBF
NyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIEhvbWUgQWdlbnQgMCAocmV2IDAz
KQpmZjoxMi4xIFBlcmZvcm1hbmNlIGNvdW50ZXJzOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9u
IEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgSG9tZSBBZ2VudCAwIChyZXYg
MDMpCmZmOjEzLjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFhlb24g
RTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hlb24gRCBNZW1vcnkgQ29udHJvbGxlciAw
IC0gVGFyZ2V0IEFkZHJlc3MvVGhlcm1hbC9SQVMgKHJldiAwMykKZmY6MTMuMSBTeXN0ZW0g
cGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hl
b24gRTMgdjQvWGVvbiBEIE1lbW9yeSBDb250cm9sbGVyIDAgLSBUYXJnZXQgQWRkcmVzcy9U
aGVybWFsL1JBUyAocmV2IDAzKQpmZjoxMy4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBD
b3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgTWVt
b3J5IENvbnRyb2xsZXIgMCAtIENoYW5uZWwgVGFyZ2V0IEFkZHJlc3MgRGVjb2RlciAocmV2
IDAzKQpmZjoxMy4zIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9u
IEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgTWVtb3J5IENvbnRyb2xsZXIg
MCAtIENoYW5uZWwgVGFyZ2V0IEFkZHJlc3MgRGVjb2RlciAocmV2IDAzKQpmZjoxMy40IFN5
c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUg
djQvWGVvbiBFMyB2NC9YZW9uIEQgTWVtb3J5IENvbnRyb2xsZXIgMCAtIENoYW5uZWwgVGFy
Z2V0IEFkZHJlc3MgRGVjb2RlciAocmV2IDAzKQpmZjoxMy41IFN5c3RlbSBwZXJpcGhlcmFs
OiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9Y
ZW9uIEQgTWVtb3J5IENvbnRyb2xsZXIgMCAtIENoYW5uZWwgVGFyZ2V0IEFkZHJlc3MgRGVj
b2RlciAocmV2IDAzKQpmZjoxMy42IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgRERSSU8gQ2hh
bm5lbCAwLzEgQnJvYWRjYXN0IChyZXYgMDMpCmZmOjEzLjcgU3lzdGVtIHBlcmlwaGVyYWw6
IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hl
b24gRCBERFJJTyBHbG9iYWwgQnJvYWRjYXN0IChyZXYgMDMpCmZmOjE0LjAgU3lzdGVtIHBl
cmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9u
IEUzIHY0L1hlb24gRCBNZW1vcnkgQ29udHJvbGxlciAwIC0gQ2hhbm5lbCAwIFRoZXJtYWwg
Q29udHJvbCAocmV2IDAzKQpmZjoxNC4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jw
b3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgTWVtb3J5
IENvbnRyb2xsZXIgMCAtIENoYW5uZWwgMSBUaGVybWFsIENvbnRyb2wgKHJldiAwMykKZmY6
MTQuMiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFNyB2NC9Y
ZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIE1lbW9yeSBDb250cm9sbGVyIDAgLSBDaGFu
bmVsIDAgRXJyb3IgKHJldiAwMykKZmY6MTQuMyBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwg
Q29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIE1l
bW9yeSBDb250cm9sbGVyIDAgLSBDaGFubmVsIDEgRXJyb3IgKHJldiAwMykKZmY6MTQuNCBT
eXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1
IHY0L1hlb24gRTMgdjQvWGVvbiBEIEREUklPIENoYW5uZWwgMC8xIEludGVyZmFjZSAocmV2
IDAzKQpmZjoxNC41IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9u
IEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgRERSSU8gQ2hhbm5lbCAwLzEg
SW50ZXJmYWNlIChyZXYgMDMpCmZmOjE0LjYgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENv
cnBvcmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hlb24gRCBERFJJ
TyBDaGFubmVsIDAvMSBJbnRlcmZhY2UgKHJldiAwMykKZmY6MTQuNyBTeXN0ZW0gcGVyaXBo
ZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMg
djQvWGVvbiBEIEREUklPIENoYW5uZWwgMC8xIEludGVyZmFjZSAocmV2IDAzKQpmZjoxNS4w
IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24g
RTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgTWVtb3J5IENvbnRyb2xsZXIgMCAtIENoYW5uZWwg
MiBUaGVybWFsIENvbnRyb2wgKHJldiAwMykKZmY6MTUuMSBTeXN0ZW0gcGVyaXBoZXJhbDog
SW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVv
biBEIE1lbW9yeSBDb250cm9sbGVyIDAgLSBDaGFubmVsIDMgVGhlcm1hbCBDb250cm9sIChy
ZXYgMDMpCmZmOjE1LjIgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFhl
b24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hlb24gRCBNZW1vcnkgQ29udHJvbGxl
ciAwIC0gQ2hhbm5lbCAyIEVycm9yIChyZXYgMDMpCmZmOjE1LjMgU3lzdGVtIHBlcmlwaGVy
YWw6IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0
L1hlb24gRCBNZW1vcnkgQ29udHJvbGxlciAwIC0gQ2hhbm5lbCAzIEVycm9yIChyZXYgMDMp
CmZmOjFlLjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTcg
djQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hlb24gRCBQb3dlciBDb250cm9sIFVuaXQgKHJl
diAwMykKZmY6MWUuMSBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gWGVv
biBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIFBvd2VyIENvbnRyb2wgVW5p
dCAocmV2IDAzKQpmZjoxZS4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlv
biBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9uIEQgUG93ZXIgQ29udHJv
bCBVbml0IChyZXYgMDMpCmZmOjFlLjMgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBv
cmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0L1hlb24gRCBQb3dlciBD
b250cm9sIFVuaXQgKHJldiAwMykKZmY6MWUuNCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwg
Q29ycG9yYXRpb24gWGVvbiBFNyB2NC9YZW9uIEU1IHY0L1hlb24gRTMgdjQvWGVvbiBEIFBv
d2VyIENvbnRyb2wgVW5pdCAocmV2IDAzKQpmZjoxZi4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEU3IHY0L1hlb24gRTUgdjQvWGVvbiBFMyB2NC9YZW9u
IEQgUG93ZXIgQ29udHJvbCBVbml0IChyZXYgMDMpCmZmOjFmLjIgU3lzdGVtIHBlcmlwaGVy
YWw6IEludGVsIENvcnBvcmF0aW9uIFhlb24gRTcgdjQvWGVvbiBFNSB2NC9YZW9uIEUzIHY0
L1hlb24gRCBQb3dlciBDb250cm9sIFVuaXQgKHJldiAwMykK
--------------F39048ABA6B92B1707D476FE
Content-Type: text/plain; charset=UTF-8;
 name="lscpu.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lscpu.txt"

QXJjaGl0ZWN0dXJlOiAgICAgICAgeDg2XzY0CkNQVSBvcC1tb2RlKHMpOiAgICAgIDMyLWJp
dCwgNjQtYml0CkJ5dGUgT3JkZXI6ICAgICAgICAgIExpdHRsZSBFbmRpYW4KQWRkcmVzcyBz
aXplczogICAgICAgNDYgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCkNQVShzKTog
ICAgICAgICAgICAgIDgKT24tbGluZSBDUFUocykgbGlzdDogMC03ClRocmVhZChzKSBwZXIg
Y29yZTogIDIKQ29yZShzKSBwZXIgc29ja2V0OiAgNApTb2NrZXQocyk6ICAgICAgICAgICAx
Ck5VTUEgbm9kZShzKTogICAgICAgIDEKVmVuZG9yIElEOiAgICAgICAgICAgR2VudWluZUlu
dGVsCkNQVSBmYW1pbHk6ICAgICAgICAgIDYKTW9kZWw6ICAgICAgICAgICAgICAgODYKTW9k
ZWwgbmFtZTogICAgICAgICAgSW50ZWwoUikgWGVvbihSKSBDUFUgRC0xNTE4IEAgMi4yMEdI
egpTdGVwcGluZzogICAgICAgICAgICAzCkNQVSBNSHo6ICAgICAgICAgICAgIDIxNDkuMzk4
CkNQVSBtYXggTUh6OiAgICAgICAgIDIyMDAuMDAwMApDUFUgbWluIE1IejogICAgICAgICA4
MDAuMDAwMApCb2dvTUlQUzogICAgICAgICAgICA0Mzk5Ljc4ClZpcnR1YWxpemF0aW9uOiAg
ICAgIFZULXgKTDFkIGNhY2hlOiAgICAgICAgICAgMzJLCkwxaSBjYWNoZTogICAgICAgICAg
IDMySwpMMiBjYWNoZTogICAgICAgICAgICAyNTZLCkwzIGNhY2hlOiAgICAgICAgICAgIDYx
NDRLCk5VTUEgbm9kZTAgQ1BVKHMpOiAgIDAtNwpGbGFnczogICAgICAgICAgICAgICBmcHUg
dm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jYSBj
bW92IHBhdCBwc2UzNiBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2UyIHNzIGh0
IHRtIHBiZSBzeXNjYWxsIG54IHBkcGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBhcmNo
X3BlcmZtb24gcGVicyBidHMgcmVwX2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2Mg
Y3B1aWQgYXBlcmZtcGVyZiBwbmkgcGNsbXVscWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2
bXggc214IGVzdCB0bTIgc3NzZTMgc2RiZyBmbWEgY3gxNiB4dHByIHBkY20gcGNpZCBkY2Eg
c3NlNF8xIHNzZTRfMiB4MmFwaWMgbW92YmUgcG9wY250IHRzY19kZWFkbGluZV90aW1lciBh
ZXMgeHNhdmUgYXZ4IGYxNmMgcmRyYW5kIGxhaGZfbG0gYWJtIDNkbm93cHJlZmV0Y2ggY3B1
aWRfZmF1bHQgZXBiIGNhdF9sMyBjZHBfbDMgaW52cGNpZF9zaW5nbGUgcHRpIGludGVsX3Bw
aW4gc3NiZCBpYnJzIGlicGIgc3RpYnAgdHByX3NoYWRvdyB2bm1pIGZsZXhwcmlvcml0eSBl
cHQgdnBpZCBlcHRfYWQgZnNnc2Jhc2UgdHNjX2FkanVzdCBibWkxIGhsZSBhdngyIHNtZXAg
Ym1pMiBlcm1zIGludnBjaWQgcnRtIGNxbSByZHRfYSByZHNlZWQgYWR4IHNtYXAgaW50ZWxf
cHQgeHNhdmVvcHQgY3FtX2xsYyBjcW1fb2NjdXBfbGxjIGNxbV9tYm1fdG90YWwgY3FtX21i
bV9sb2NhbCBkdGhlcm0gYXJhdCBwbG4gcHRzIG1kX2NsZWFyIGZsdXNoX2wxZAo=
--------------F39048ABA6B92B1707D476FE
Content-Type: text/plain; charset=UTF-8;
 name="lsmod.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lsmod.txt"

TW9kdWxlICAgICAgICAgICAgICAgICAgU2l6ZSAgVXNlZCBieQpicmlkZ2UgICAgICAgICAg
ICAgICAgMjA4ODk2ICAwCjgwMjFxICAgICAgICAgICAgICAgICAgMzI3NjggIDAKZ2FycCAg
ICAgICAgICAgICAgICAgICAxNjM4NCAgMSA4MDIxcQpzdHAgICAgICAgICAgICAgICAgICAg
IDE2Mzg0ICAyIGJyaWRnZSxnYXJwCm1ycCAgICAgICAgICAgICAgICAgICAgMjA0ODAgIDEg
ODAyMXEKbGxjICAgICAgICAgICAgICAgICAgICAxNjM4NCAgMyBicmlkZ2Usc3RwLGdhcnAK
bmZfbG9nX2lwdjYgICAgICAgICAgICAxNjM4NCAgMwppcDZ0X1JFSkVDVCAgICAgICAgICAg
IDE2Mzg0ICAxCm5mX3JlamVjdF9pcHY2ICAgICAgICAgMjA0ODAgIDEgaXA2dF9SRUpFQ1QK
eHRfbGltaXQgICAgICAgICAgICAgICAxNjM4NCAgMQppcDZ0X3J0ICAgICAgICAgICAgICAg
IDIwNDgwICAzCmlwNnRfaXB2NmhlYWRlciAgICAgICAgMTYzODQgIDEwCmlwNnRhYmxlX2Zp
bHRlciAgICAgICAgMTYzODQgIDEKaXA2X3RhYmxlcyAgICAgICAgICAgICAzMjc2OCAgMTgg
aXA2dGFibGVfZmlsdGVyCm5mX2xvZ19pcHY0ICAgICAgICAgICAgMTYzODQgIDMKbmZfbG9n
X2NvbW1vbiAgICAgICAgICAxNjM4NCAgMiBuZl9sb2dfaXB2NCxuZl9sb2dfaXB2NgppcHRf
UkVKRUNUICAgICAgICAgICAgIDE2Mzg0ICAxCm5mX3JlamVjdF9pcHY0ICAgICAgICAgMTYz
ODQgIDEgaXB0X1JFSkVDVAp4dF9MT0cgICAgICAgICAgICAgICAgIDIwNDgwICA2Cnh0X3Rj
cHVkcCAgICAgICAgICAgICAgMjA0ODAgIDE4Cnh0X3N0YXRlICAgICAgICAgICAgICAgMTYz
ODQgIDAKeHRfY29ubnRyYWNrICAgICAgICAgICAxNjM4NCAgMgpuZl9jb25udHJhY2sgICAg
ICAgICAgMTU5NzQ0ICAyIHh0X2Nvbm50cmFjayx4dF9zdGF0ZQpuZl9kZWZyYWdfaXB2NiAg
ICAgICAgIDI0NTc2ICAxIG5mX2Nvbm50cmFjawpsaWJjcmMzMmMgICAgICAgICAgICAgIDE2
Mzg0ICAxIG5mX2Nvbm50cmFjawpuZl9kZWZyYWdfaXB2NCAgICAgICAgIDE2Mzg0ICAxIG5m
X2Nvbm50cmFjawppcHRhYmxlX2ZpbHRlciAgICAgICAgIDE2Mzg0ICAxCmNwdWZyZXFfcG93
ZXJzYXZlICAgICAgMjA0ODAgIDAKY3B1ZnJlcV91c2Vyc3BhY2UgICAgICAyMDQ4MCAgMApj
cHVmcmVxX2NvbnNlcnZhdGl2ZSAgICAxNjM4NCAgMAppcG1pX3NzaWYgICAgICAgICAgICAg
IDQwOTYwICAwCm5sc19hc2NpaSAgICAgICAgICAgICAgMTYzODQgIDEKbmxzX2NwNDM3ICAg
ICAgICAgICAgICAyMDQ4MCAgMQp2ZmF0ICAgICAgICAgICAgICAgICAgIDIwNDgwICAxCmZh
dCAgICAgICAgICAgICAgICAgICAgODYwMTYgIDEgdmZhdAppbnRlbF9yYXBsX21zciAgICAg
ICAgIDIwNDgwICAwCmludGVsX3JhcGxfY29tbW9uICAgICAgMzI3NjggIDEgaW50ZWxfcmFw
bF9tc3IKc2JfZWRhYyAgICAgICAgICAgICAgICAyNDU3NiAgMAp4ODZfcGtnX3RlbXBfdGhl
cm1hbCAgICAyMDQ4MCAgMAppbnRlbF9wb3dlcmNsYW1wICAgICAgIDIwNDgwICAwCmNvcmV0
ZW1wICAgICAgICAgICAgICAgMjA0ODAgIDAKa3ZtX2ludGVsICAgICAgICAgICAgIDI1Mzk1
MiAgMAprdm0gICAgICAgICAgICAgICAgICAgODE5MjAwICAxIGt2bV9pbnRlbAppcnFieXBh
c3MgICAgICAgICAgICAgIDE2Mzg0ICAxIGt2bQpjcmN0MTBkaWZfcGNsbXVsICAgICAgIDE2
Mzg0ICAxCmNyYzMyX3BjbG11bCAgICAgICAgICAgMTYzODQgIDAKZ2hhc2hfY2xtdWxuaV9p
bnRlbCAgICAxNjM4NCAgMApteG1fd21pICAgICAgICAgICAgICAgIDE2Mzg0ICAwCmFlc25p
X2ludGVsICAgICAgICAgICAzNzI3MzYgIDAKZ2x1ZV9oZWxwZXIgICAgICAgICAgICAxNjM4
NCAgMSBhZXNuaV9pbnRlbApjcnlwdG9fc2ltZCAgICAgICAgICAgIDE2Mzg0ICAxIGFlc25p
X2ludGVsCmVmaV9wc3RvcmUgICAgICAgICAgICAgMTYzODQgIDAKY3J5cHRkICAgICAgICAg
ICAgICAgICAyNDU3NiAgMiBjcnlwdG9fc2ltZCxnaGFzaF9jbG11bG5pX2ludGVsCnJhcGwg
ICAgICAgICAgICAgICAgICAgMTYzODQgIDAKaW50ZWxfY3N0YXRlICAgICAgICAgICAyMDQ4
MCAgMAphc3QgICAgICAgICAgICAgICAgICAgIDU3MzQ0ICAwCmRybV92cmFtX2hlbHBlciAg
ICAgICAgMjg2NzIgIDEgYXN0CmludGVsX3VuY29yZSAgICAgICAgICAxNjM4NDAgIDAKZWZp
dmFycyAgICAgICAgICAgICAgICAyMDQ4MCAgMSBlZmlfcHN0b3JlCmRybV9rbXNfaGVscGVy
ICAgICAgICAyNTgwNDggIDQgZHJtX3ZyYW1faGVscGVyLGFzdApjZWMgICAgICAgICAgICAg
ICAgICAgIDQ5MTUyICAxIGRybV9rbXNfaGVscGVyCmRybV90dG1faGVscGVyICAgICAgICAg
MTYzODQgIDEgZHJtX3ZyYW1faGVscGVyCmlUQ09fd2R0ICAgICAgICAgICAgICAgMTYzODQg
IDAKdHRtICAgICAgICAgICAgICAgICAgIDEyMjg4MCAgMiBkcm1fdnJhbV9oZWxwZXIsZHJt
X3R0bV9oZWxwZXIKaVRDT192ZW5kb3Jfc3VwcG9ydCAgICAxNjM4NCAgMSBpVENPX3dkdApp
bnRlbF9wY2hfdGhlcm1hbCAgICAgIDE2Mzg0ICAwCmRybSAgICAgICAgICAgICAgICAgICA1
OTgwMTYgIDYgZHJtX2ttc19oZWxwZXIsZHJtX3ZyYW1faGVscGVyLGFzdCxkcm1fdHRtX2hl
bHBlcix0dG0KbWVpX21lICAgICAgICAgICAgICAgICA0NTA1NiAgMApldmRldiAgICAgICAg
ICAgICAgICAgIDI0NTc2ICAzCmpveWRldiAgICAgICAgICAgICAgICAgMjg2NzIgIDAKbWVp
ICAgICAgICAgICAgICAgICAgIDEyMjg4MCAgMSBtZWlfbWUKaW9hdGRtYSAgICAgICAgICAg
ICAgICA2MTQ0MCAgMAppcG1pX3NpICAgICAgICAgICAgICAgIDY5NjMyICAwCmlwbWlfZGV2
aW50ZiAgICAgICAgICAgMjA0ODAgIDAKaXBtaV9tc2doYW5kbGVyICAgICAgICA3MzcyOCAg
MyBpcG1pX2RldmludGYsaXBtaV9zaSxpcG1pX3NzaWYKd21pICAgICAgICAgICAgICAgICAg
ICAzNjg2NCAgMSBteG1fd21pCmFjcGlfcGFkICAgICAgICAgICAgICAgMjg2NzIgIDAKYnV0
dG9uICAgICAgICAgICAgICAgICAyNDU3NiAgMAplZml2YXJmcyAgICAgICAgICAgICAgIDE2
Mzg0ICAxCmlwX3RhYmxlcyAgICAgICAgICAgICAgMzI3NjggIDEgaXB0YWJsZV9maWx0ZXIK
eF90YWJsZXMgICAgICAgICAgICAgICA1MzI0OCAgMTMgaXA2dGFibGVfZmlsdGVyLHh0X2Nv
bm50cmFjayxpcHRhYmxlX2ZpbHRlcix4dF9MT0cseHRfc3RhdGUseHRfdGNwdWRwLGlwNnRf
aXB2NmhlYWRlcixpcDZ0X3J0LGlwNl90YWJsZXMsaXB0X1JFSkVDVCxpcF90YWJsZXMseHRf
bGltaXQsaXA2dF9SRUpFQ1QKYXV0b2ZzNCAgICAgICAgICAgICAgICA1MzI0OCAgMApleHQ0
ICAgICAgICAgICAgICAgICAgNzcwMDQ4ICAxCmNyYzMyY19nZW5lcmljICAgICAgICAgMTYz
ODQgIDAKY3JjMTYgICAgICAgICAgICAgICAgICAxNjM4NCAgMSBleHQ0Cm1iY2FjaGUgICAg
ICAgICAgICAgICAgMTYzODQgIDEgZXh0NApqYmQyICAgICAgICAgICAgICAgICAgMTM5MjY0
ICAxIGV4dDQKZG1fbW9kICAgICAgICAgICAgICAgIDE1MTU1MiAgOApoaWRfZ2VuZXJpYyAg
ICAgICAgICAgIDE2Mzg0ICAwCnVzYmhpZCAgICAgICAgICAgICAgICAgNjU1MzYgIDAKaGlk
ICAgICAgICAgICAgICAgICAgIDEzOTI2NCAgMiB1c2JoaWQsaGlkX2dlbmVyaWMKZWhjaV9w
Y2kgICAgICAgICAgICAgICAyMDQ4MCAgMAp4aGNpX3BjaSAgICAgICAgICAgICAgIDIwNDgw
ICAwCnhoY2lfaGNkICAgICAgICAgICAgICAyOTA4MTYgIDEgeGhjaV9wY2kKZWhjaV9oY2Qg
ICAgICAgICAgICAgICA5ODMwNCAgMSBlaGNpX3BjaQpudm1lICAgICAgICAgICAgICAgICAg
IDQ5MTUyICAyCml4Z2JlICAgICAgICAgICAgICAgICAzNjg2NDAgIDAKY3JjMzJjX2ludGVs
ICAgICAgICAgICAyNDU3NiAgMwptZGlvICAgICAgICAgICAgICAgICAgIDE2Mzg0ICAxIGl4
Z2JlCmkyY19pODAxICAgICAgICAgICAgICAgMzI3NjggIDAKbHBjX2ljaCAgICAgICAgICAg
ICAgICAyODY3MiAgMApudm1lX2NvcmUgICAgICAgICAgICAgMTEwNTkyICA0IG52bWUKaTJj
X3NtYnVzICAgICAgICAgICAgICAyMDQ4MCAgMSBpMmNfaTgwMQptZmRfY29yZSAgICAgICAg
ICAgICAgIDIwNDgwICAxIGxwY19pY2gKaWdiICAgICAgICAgICAgICAgICAgIDI0OTg1NiAg
MApsaWJwaHkgICAgICAgICAgICAgICAgMTQ3NDU2ICAxIGl4Z2JlCmkyY19hbGdvX2JpdCAg
ICAgICAgICAgMTYzODQgIDIgaWdiLGFzdAp1c2Jjb3JlICAgICAgICAgICAgICAgMzE1Mzky
ICA1IHhoY2lfaGNkLGVoY2lfcGNpLHVzYmhpZCxlaGNpX2hjZCx4aGNpX3BjaQpkY2EgICAg
ICAgICAgICAgICAgICAgIDE2Mzg0ICAzIGlnYixpb2F0ZG1hLGl4Z2JlCnQxMF9waSAgICAg
ICAgICAgICAgICAgMTYzODQgIDEgbnZtZV9jb3JlCg==
--------------F39048ABA6B92B1707D476FE
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-disable-quirk-for-Xeon-D-1500-d2345d1231d80ecbea5fb7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-disable-quirk-for-Xeon-D-1500-d2345d1231d80ecbea5fb7.pa";
 filename*1="tch"

From: Stefan Buehler <stefan.buehler@tik.uni-stuttgart.de>
Date: Wed, 16 Sep 2020 11:37:18 +0200
Subject: [PATCH 1/1] disable quirk for Xeon D-1500
 (d2345d1231d80ecbea5fb764eb43123440861462)

---
 drivers/pci/quirks.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index af2149632102..aefc272ae0d9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1983,7 +1983,6 @@ static void quirk_disable_intel_boot_interrupt(struct pci_dev *dev)
 	case 0x3c28:	/* Xeon E5 1600/2600/4600	*/
 	case 0x0e28:	/* Xeon E5/E7 V2		*/
 	case 0x2f28:	/* Xeon E5/E7 V3,V4		*/
-	case 0x6f28:	/* Xeon D-1500			*/
 	case 0x2034:	/* Xeon Scalable Family		*/
 		pci_read_config_dword(dev, INTEL_CIPINTRC_CFG_OFFSET,
 				      &pci_config_dword);
@@ -2019,8 +2018,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x0e28,
 		quirk_disable_intel_boot_interrupt);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2f28,
 		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x6f28,
-		quirk_disable_intel_boot_interrupt);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2034,
 		quirk_disable_intel_boot_interrupt);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x3c28,
@@ -2029,8 +2026,6 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x0e28,
 		quirk_disable_intel_boot_interrupt);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x2f28,
 		quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x6f28,
-		quirk_disable_intel_boot_interrupt);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x2034,
 		quirk_disable_intel_boot_interrupt);
 
-- 
2.20.1


--------------F39048ABA6B92B1707D476FE
Content-Type: text/x-log; charset=UTF-8;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kern.log"

-- Logs begin at Wed 2020-09-16 11:55:06 CEST, end at Wed 2020-09-16 12:07:20 CEST. --
Sep 16 11:55:06 oob-pr10-y1 kernel: microcode: microcode updated early to revision 0x7000019, date = 2019-06-17
Sep 16 11:55:06 oob-pr10-y1 kernel: Linux version 5.8.9 (russbueh@oob-pr10-y1) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #15 SMP Wed Sep 16 11:44:56 CEST 2020
Sep 16 11:55:06 oob-pr10-y1 kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-5.8.9 root=/dev/mapper/vg00-root ro biosdevname=0 noplymouth console=tty0 console=ttyS1,115200n8 8250.nr_uarts=68
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-provided physical RAM map:
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000795d4fff] usable
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x00000000795d5000-0x00000000797a5fff] reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x00000000797a6000-0x000000007989efff] usable
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x000000007989f000-0x0000000079d42fff] ACPI NVS
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x0000000079d43000-0x000000007bd4cfff] reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x000000007bd4d000-0x000000007bdb0fff] type 20
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x000000007bdb1000-0x000000007bdb1fff] usable
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x000000007bdb2000-0x000000007be37fff] reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x000000007be38000-0x000000007bffffff] usable
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable
Sep 16 11:55:06 oob-pr10-y1 kernel: NX (Execute Disable) protection: active
Sep 16 11:55:06 oob-pr10-y1 kernel: efi: EFI v2.40 by American Megatrends
Sep 16 11:55:06 oob-pr10-y1 kernel: efi: ACPI=0x798e7000 ACPI 2.0=0x798e7000 ESRT=0x7bb14e18 SMBIOS=0xf05b0 
Sep 16 11:55:06 oob-pr10-y1 kernel: SMBIOS 2.8 present.
Sep 16 11:55:06 oob-pr10-y1 kernel: DMI: Supermicro Super Server/X10SDV-TP8F, BIOS 1.0c 10/31/2017
Sep 16 11:55:06 oob-pr10-y1 kernel: tsc: Fast TSC calibration using PIT
Sep 16 11:55:06 oob-pr10-y1 kernel: tsc: Detected 2199.892 MHz processor
Sep 16 11:55:06 oob-pr10-y1 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Sep 16 11:55:06 oob-pr10-y1 kernel: last_pfn = 0x280000 max_arch_pfn = 0x400000000
Sep 16 11:55:06 oob-pr10-y1 kernel: MTRR default type: write-back
Sep 16 11:55:06 oob-pr10-y1 kernel: MTRR fixed ranges enabled:
Sep 16 11:55:06 oob-pr10-y1 kernel:   00000-9FFFF write-back
Sep 16 11:55:06 oob-pr10-y1 kernel:   A0000-BFFFF uncachable
Sep 16 11:55:06 oob-pr10-y1 kernel:   C0000-FFFFF write-protect
Sep 16 11:55:06 oob-pr10-y1 kernel: MTRR variable ranges enabled:
Sep 16 11:55:06 oob-pr10-y1 kernel:   0 base 000080000000 mask 3FFF80000000 uncachable
Sep 16 11:55:06 oob-pr10-y1 kernel:   1 base 380000000000 mask 3FC000000000 uncachable
Sep 16 11:55:06 oob-pr10-y1 kernel:   2 base 0000FBA00000 mask 3FFFFFE00000 write-through
Sep 16 11:55:06 oob-pr10-y1 kernel:   3 base 0000FBC00000 mask 3FFFFFE00000 write-through
Sep 16 11:55:06 oob-pr10-y1 kernel:   4 base 0000FBE00000 mask 3FFFFFF00000 write-through
Sep 16 11:55:06 oob-pr10-y1 kernel:   5 disabled
Sep 16 11:55:06 oob-pr10-y1 kernel:   6 disabled
Sep 16 11:55:06 oob-pr10-y1 kernel:   7 disabled
Sep 16 11:55:06 oob-pr10-y1 kernel:   8 disabled
Sep 16 11:55:06 oob-pr10-y1 kernel:   9 disabled
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Sep 16 11:55:06 oob-pr10-y1 kernel: last_pfn = 0x7c000 max_arch_pfn = 0x400000000
Sep 16 11:55:06 oob-pr10-y1 kernel: found SMP MP-table at [mem 0x000fda10-0x000fda1f]
Sep 16 11:55:06 oob-pr10-y1 kernel: esrt: Reserving ESRT space from 0x000000007bb14e18 to 0x000000007bb14e50.
Sep 16 11:55:06 oob-pr10-y1 kernel: Using GB pages for direct mapping
Sep 16 11:55:06 oob-pr10-y1 kernel: Secure boot could not be determined
Sep 16 11:55:06 oob-pr10-y1 kernel: RAMDISK: [mem 0x3688f000-0x3743efff]
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Early table checksum verification disabled
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: RSDP 0x00000000798E7000 000024 (v02 SUPERM)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: XSDT 0x00000000798E70A0 0000BC (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: FACP 0x00000000798FFAD0 00010C (v05 SUPERM SMCI--MB 01072009 AMI  00010013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: DSDT 0x00000000798E71F0 0188E0 (v02 SUPERM SMCI--MB 01072009 INTL 20091013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: FACS 0x0000000079D41F80 000040
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: APIC 0x00000000798FFBE0 0000BC (v03 SUPERM SMCI--MB 01072009 AMI  00010013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: FPDT 0x00000000798FFCA0 000044 (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: FIDT 0x00000000798FFCE8 00009C (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: SPMI 0x00000000798FFD88 000041 (v05 SUPERM SMCI--MB 00000000 AMI. 00000000)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: MCFG 0x00000000798FFDD0 00003C (v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: UEFI 0x00000000798FFE10 000042 (v01                 00000000      00000000)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: DBG2 0x00000000798FFE58 000072 (v00 SUPERM SMCI--MB 00000000 INTL 20091013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: HPET 0x00000000798FFED0 000038 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: WDDT 0x00000000798FFF08 000040 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: SSDT 0x00000000798FFF48 00EDCB (v01 AMI    PmMgt    00000001 INTL 20120913)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: SSDT 0x000000007990ED18 0020C5 (v02 SUPERM SpsNm    00000002 INTL 20120913)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: SSDT 0x0000000079910DE0 000064 (v02 SUPERM SpsNvs   00000002 INTL 20120913)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PRAD 0x0000000079910E48 000102 (v02 SUPERM SMCI--MB 00000002 INTL 20120913)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: DMAR 0x0000000079910F50 0000CC (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: HEST 0x0000000079911020 0000A8 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: BERT 0x00000000799110C8 000030 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: ERST 0x00000000799110F8 000230 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: EINJ 0x0000000079911328 000130 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Local APIC address 0xfee00000
Sep 16 11:55:06 oob-pr10-y1 kernel: No NUMA configuration found
Sep 16 11:55:06 oob-pr10-y1 kernel: Faking a node at [mem 0x0000000000000000-0x000000027fffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: NODE_DATA(0) allocated [mem 0x27fffb000-0x27fffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: Zone ranges:
Sep 16 11:55:06 oob-pr10-y1 kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel:   Normal   [mem 0x0000000100000000-0x000000027fffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel:   Device   empty
Sep 16 11:55:06 oob-pr10-y1 kernel: Movable zone start for each node
Sep 16 11:55:06 oob-pr10-y1 kernel: Early memory node ranges
Sep 16 11:55:06 oob-pr10-y1 kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel:   node   0: [mem 0x0000000000100000-0x00000000795d4fff]
Sep 16 11:55:06 oob-pr10-y1 kernel:   node   0: [mem 0x00000000797a6000-0x000000007989efff]
Sep 16 11:55:06 oob-pr10-y1 kernel:   node   0: [mem 0x000000007bdb1000-0x000000007bdb1fff]
Sep 16 11:55:06 oob-pr10-y1 kernel:   node   0: [mem 0x000000007be38000-0x000000007bffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel:   node   0: [mem 0x0000000100000000-0x000000027fffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: Zeroed struct page in unavailable ranges: 26570 pages
Sep 16 11:55:06 oob-pr10-y1 kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000027fffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: On node 0 totalpages: 2070582
Sep 16 11:55:06 oob-pr10-y1 kernel:   DMA zone: 64 pages used for memmap
Sep 16 11:55:06 oob-pr10-y1 kernel:   DMA zone: 27 pages reserved
Sep 16 11:55:06 oob-pr10-y1 kernel:   DMA zone: 3999 pages, LIFO batch:0
Sep 16 11:55:06 oob-pr10-y1 kernel:   DMA32 zone: 7715 pages used for memmap
Sep 16 11:55:06 oob-pr10-y1 kernel:   DMA32 zone: 493719 pages, LIFO batch:63
Sep 16 11:55:06 oob-pr10-y1 kernel:   Normal zone: 24576 pages used for memmap
Sep 16 11:55:06 oob-pr10-y1 kernel:   Normal zone: 1572864 pages, LIFO batch:63
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PM-Timer IO Port: 0x408
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Local APIC address 0xfee00000
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
Sep 16 11:55:06 oob-pr10-y1 kernel: IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: IRQ0 used by override.
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: IRQ9 used by override.
Sep 16 11:55:06 oob-pr10-y1 kernel: Using ACPI (MADT) for SMP configuration information
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: HPET id: 0x8086a701 base: 0xfed00000
Sep 16 11:55:06 oob-pr10-y1 kernel: TSC deadline timer available
Sep 16 11:55:06 oob-pr10-y1 kernel: smpboot: Allowing 8 CPUs, 0 hotplug CPUs
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x795d5000-0x797a5fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x7989f000-0x79d42fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x79d43000-0x7bd4cfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x7bd4d000-0x7bdb0fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x7bdb2000-0x7be37fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x7c000000-0x7fffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x80000000-0x8fffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0x90000000-0xfed1bfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfeffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: [mem 0x90000000-0xfed1bfff] available for PCI devices
Sep 16 11:55:06 oob-pr10-y1 kernel: Booting paravirtualized kernel on bare hardware
Sep 16 11:55:06 oob-pr10-y1 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Sep 16 11:55:06 oob-pr10-y1 kernel: setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
Sep 16 11:55:06 oob-pr10-y1 kernel: percpu: Embedded 54 pages/cpu s184280 r8192 d28712 u262144
Sep 16 11:55:06 oob-pr10-y1 kernel: pcpu-alloc: s184280 r8192 d28712 u262144 alloc=1*2097152
Sep 16 11:55:06 oob-pr10-y1 kernel: pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Sep 16 11:55:06 oob-pr10-y1 kernel: Built 1 zonelists, mobility grouping on.  Total pages: 2038200
Sep 16 11:55:06 oob-pr10-y1 kernel: Policy zone: Normal
Sep 16 11:55:06 oob-pr10-y1 kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.8.9 root=/dev/mapper/vg00-root ro biosdevname=0 noplymouth console=tty0 console=ttyS1,115200n8 8250.nr_uarts=68
Sep 16 11:55:06 oob-pr10-y1 kernel: Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: mem auto-init: stack:off, heap alloc:off, heap free:off
Sep 16 11:55:06 oob-pr10-y1 kernel: Memory: 7957636K/8282328K available (10243K kernel code, 1257K rwdata, 3644K rodata, 1604K init, 2096K bss, 324692K reserved, 0K cma-reserved)
Sep 16 11:55:06 oob-pr10-y1 kernel: random: get_random_u64 called from __kmem_cache_create+0x3e/0x520 with crng_init=0
Sep 16 11:55:06 oob-pr10-y1 kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Sep 16 11:55:06 oob-pr10-y1 kernel: Kernel/User page tables isolation: enabled
Sep 16 11:55:06 oob-pr10-y1 kernel: ftrace: allocating 33926 entries in 133 pages
Sep 16 11:55:06 oob-pr10-y1 kernel: ftrace: allocated 133 pages with 3 groups
Sep 16 11:55:06 oob-pr10-y1 kernel: rcu: Hierarchical RCU implementation.
Sep 16 11:55:06 oob-pr10-y1 kernel: rcu:         RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
Sep 16 11:55:06 oob-pr10-y1 kernel:         Rude variant of Tasks RCU enabled.
Sep 16 11:55:06 oob-pr10-y1 kernel: rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
Sep 16 11:55:06 oob-pr10-y1 kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
Sep 16 11:55:06 oob-pr10-y1 kernel: NR_IRQS: 33024, nr_irqs: 488, preallocated irqs: 16
Sep 16 11:55:06 oob-pr10-y1 kernel: random: crng done (trusting CPU's manufacturer)
Sep 16 11:55:06 oob-pr10-y1 kernel: Console: colour dummy device 80x25
Sep 16 11:55:06 oob-pr10-y1 kernel: printk: console [tty0] enabled
Sep 16 11:55:06 oob-pr10-y1 kernel: printk: console [ttyS1] enabled
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Core revision 20200528
Sep 16 11:55:06 oob-pr10-y1 kernel: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
Sep 16 11:55:06 oob-pr10-y1 kernel: APIC: Switch to symmetric I/O mode setup
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR: Host address width 46
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020de
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR: RMRR base: 0x0000007bb24000 end: 0x0000007bb32fff
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR: ATSR flags: 0x0
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR: RHSA base: 0x000000fbffc000 proximity domain: 0x0
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR-IR: IOAPIC id 8 under DRHD base  0xfbffc000 IOMMU 0
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
Sep 16 11:55:06 oob-pr10-y1 kernel: DMAR-IR: Enabled IRQ remapping in xapic mode
Sep 16 11:55:06 oob-pr10-y1 kernel: x2apic: IRQ remapping doesn't support X2APIC mode
Sep 16 11:55:06 oob-pr10-y1 kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Sep 16 11:55:06 oob-pr10-y1 kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fb5cca0860, max_idle_ns: 440795204466 ns
Sep 16 11:55:06 oob-pr10-y1 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 4399.78 BogoMIPS (lpj=8799568)
Sep 16 11:55:06 oob-pr10-y1 kernel: pid_max: default: 32768 minimum: 301
Sep 16 11:55:06 oob-pr10-y1 kernel: LSM: Security Framework initializing
Sep 16 11:55:06 oob-pr10-y1 kernel: Yama: becoming mindful.
Sep 16 11:55:06 oob-pr10-y1 kernel: AppArmor: AppArmor initialized
Sep 16 11:55:06 oob-pr10-y1 kernel: TOMOYO Linux initialized
Sep 16 11:55:06 oob-pr10-y1 kernel: Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: mce: CPU0: Thermal monitoring enabled (TM1)
Sep 16 11:55:06 oob-pr10-y1 kernel: process: using mwait in idle threads
Sep 16 11:55:06 oob-pr10-y1 kernel: Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Sep 16 11:55:06 oob-pr10-y1 kernel: Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Sep 16 11:55:06 oob-pr10-y1 kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Sep 16 11:55:06 oob-pr10-y1 kernel: Spectre V2 : Mitigation: Full generic retpoline
Sep 16 11:55:06 oob-pr10-y1 kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Sep 16 11:55:06 oob-pr10-y1 kernel: Spectre V2 : Enabling Restricted Speculation for firmware calls
Sep 16 11:55:06 oob-pr10-y1 kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Sep 16 11:55:06 oob-pr10-y1 kernel: Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
Sep 16 11:55:06 oob-pr10-y1 kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
Sep 16 11:55:06 oob-pr10-y1 kernel: TAA: Mitigation: Clear CPU buffers
Sep 16 11:55:06 oob-pr10-y1 kernel: MDS: Mitigation: Clear CPU buffers
Sep 16 11:55:06 oob-pr10-y1 kernel: Freeing SMP alternatives memory: 32K
Sep 16 11:55:06 oob-pr10-y1 kernel: smpboot: CPU0: Intel(R) Xeon(R) CPU D-1518 @ 2.20GHz (family: 0x6, model: 0x56, stepping: 0x3)
Sep 16 11:55:06 oob-pr10-y1 kernel: Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR, full-width counters, Intel PMU driver.
Sep 16 11:55:06 oob-pr10-y1 kernel: ... version:                3
Sep 16 11:55:06 oob-pr10-y1 kernel: ... bit width:              48
Sep 16 11:55:06 oob-pr10-y1 kernel: ... generic registers:      4
Sep 16 11:55:06 oob-pr10-y1 kernel: ... value mask:             0000ffffffffffff
Sep 16 11:55:06 oob-pr10-y1 kernel: ... max period:             00007fffffffffff
Sep 16 11:55:06 oob-pr10-y1 kernel: ... fixed-purpose events:   3
Sep 16 11:55:06 oob-pr10-y1 kernel: ... event mask:             000000070000000f
Sep 16 11:55:06 oob-pr10-y1 kernel: rcu: Hierarchical SRCU implementation.
Sep 16 11:55:06 oob-pr10-y1 kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Sep 16 11:55:06 oob-pr10-y1 kernel: smp: Bringing up secondary CPUs ...
Sep 16 11:55:06 oob-pr10-y1 kernel: x86: Booting SMP configuration:
Sep 16 11:55:06 oob-pr10-y1 kernel: .... node  #0, CPUs:      #1 #2 #3 #4
Sep 16 11:55:06 oob-pr10-y1 kernel: MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
Sep 16 11:55:06 oob-pr10-y1 kernel: TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
Sep 16 11:55:06 oob-pr10-y1 kernel:  #5 #6 #7
Sep 16 11:55:06 oob-pr10-y1 kernel: smp: Brought up 1 node, 8 CPUs
Sep 16 11:55:06 oob-pr10-y1 kernel: smpboot: Max logical packages: 1
Sep 16 11:55:06 oob-pr10-y1 kernel: smpboot: Total of 8 processors activated (35198.27 BogoMIPS)
Sep 16 11:55:06 oob-pr10-y1 kernel: devtmpfs: initialized
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/mm: Memory block size: 128MB
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: Registering ACPI NVS region [mem 0x7989f000-0x79d42fff] (4866048 bytes)
Sep 16 11:55:06 oob-pr10-y1 kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Sep 16 11:55:06 oob-pr10-y1 kernel: futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: pinctrl core: initialized pinctrl subsystem
Sep 16 11:55:06 oob-pr10-y1 kernel: thermal_sys: Registered thermal governor 'fair_share'
Sep 16 11:55:06 oob-pr10-y1 kernel: thermal_sys: Registered thermal governor 'bang_bang'
Sep 16 11:55:06 oob-pr10-y1 kernel: thermal_sys: Registered thermal governor 'step_wise'
Sep 16 11:55:06 oob-pr10-y1 kernel: thermal_sys: Registered thermal governor 'user_space'
Sep 16 11:55:06 oob-pr10-y1 kernel: NET: Registered protocol family 16
Sep 16 11:55:06 oob-pr10-y1 kernel: audit: initializing netlink subsys (disabled)
Sep 16 11:55:06 oob-pr10-y1 kernel: audit: type=2000 audit(1600250095.300:1): state=initialized audit_enabled=0 res=1
Sep 16 11:55:06 oob-pr10-y1 kernel: cpuidle: using governor ladder
Sep 16 11:55:06 oob-pr10-y1 kernel: cpuidle: using governor menu
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: bus type PCI registered
Sep 16 11:55:06 oob-pr10-y1 kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI: Using configuration type 1 for base access
Sep 16 11:55:06 oob-pr10-y1 kernel: ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
Sep 16 11:55:06 oob-pr10-y1 kernel: HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
Sep 16 11:55:06 oob-pr10-y1 kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Added _OSI(Module Device)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Added _OSI(Processor Device)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Added _OSI(Processor Aggregator Device)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Added _OSI(Linux-Dell-Video)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: 4 ACPI AML tables successfully acquired and loaded
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Dynamic OEM Table Load:
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Interpreter enabled
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: (supports S0 S4 S5)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Using IOAPIC for interrupt routing
Sep 16 11:55:06 oob-pr10-y1 kernel: HEST: Table parsing has been initialized.
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: Enabled 6 GPEs in block 00 to 3F
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
Sep 16 11:55:06 oob-pr10-y1 kernel: acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
Sep 16 11:55:06 oob-pr10-y1 kernel: acpi PNP0A03:03: _OSC: platform does not support [SHPCHotplug LTR]
Sep 16 11:55:06 oob-pr10-y1 kernel: acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
Sep 16 11:55:06 oob-pr10-y1 kernel: acpi PNP0A03:03: FADT indicates ASPM is unsupported, using BIOS configuration
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI host bridge to bus 0000:ff
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:ff: root bus resource [bus ff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0b.0: [8086:6f81] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0b.1: [8086:6f36] type 00 class 0x110100
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0b.2: [8086:6f37] type 00 class 0x110100
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0b.3: [8086:6f76] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0c.0: [8086:6fe0] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0c.1: [8086:6fe1] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0c.2: [8086:6fe2] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0c.3: [8086:6fe3] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0f.0: [8086:6ff8] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0f.4: [8086:6ffc] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0f.5: [8086:6ffd] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:0f.6: [8086:6ffe] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:10.0: [8086:6f1d] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:10.1: [8086:6f34] type 00 class 0x110100
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:10.5: [8086:6f1e] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:10.6: [8086:6f7d] type 00 class 0x110100
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:10.7: [8086:6f1f] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:12.0: [8086:6fa0] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:12.1: [8086:6f30] type 00 class 0x110100
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:13.0: [8086:6fa8] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:13.1: [8086:6f71] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:13.2: [8086:6faa] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:13.3: [8086:6fab] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:13.4: [8086:6fac] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:13.5: [8086:6fad] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:13.6: [8086:6fae] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:13.7: [8086:6faf] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:14.0: [8086:6fb0] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:14.1: [8086:6fb1] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:14.2: [8086:6fb2] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:14.3: [8086:6fb3] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:14.4: [8086:6fbc] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:14.5: [8086:6fbd] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:14.6: [8086:6fbe] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:14.7: [8086:6fbf] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:15.0: [8086:6fb4] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:15.1: [8086:6fb5] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:15.2: [8086:6fb6] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:15.3: [8086:6fb7] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:1e.0: [8086:6f98] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:1e.1: [8086:6f99] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:1e.2: [8086:6f9a] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:1e.3: [8086:6fc0] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:1e.4: [8086:6f9c] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:1f.0: [8086:6f88] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:ff:1f.2: [8086:6f8a] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
Sep 16 11:55:06 oob-pr10-y1 kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
Sep 16 11:55:06 oob-pr10-y1 kernel: acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug PME AER LTR]
Sep 16 11:55:06 oob-pr10-y1 kernel: acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PCIeCapability]
Sep 16 11:55:06 oob-pr10-y1 kernel: acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI host bridge to bus 0000:00
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: root bus resource [mem 0x90000000-0xfbffbfff window]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: root bus resource [bus 00-fe]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:00.0: [8086:6f00] type 00 class 0x060000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.0: [8086:6f02] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.1: [8086:6f03] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.0: [8086:6f04] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2: [8086:6f06] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0: [8086:6f08] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.2: [8086:6f0a] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:05.0: [8086:6f28] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:05.1: [8086:6f29] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:05.2: [8086:6f2a] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:14.0: reg 0x10: [mem 0xfb800000-0xfb80ffff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:14.0: PME# supported from D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:16.0: reg 0x10: [mem 0xfb816000-0xfb81600f 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:16.1: [8086:8c3b] type 00 class 0x078000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:16.1: reg 0x10: [mem 0xfb815000-0xfb81500f 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1a.0: reg 0x10: [mem 0xfb813000-0xfb8133ff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1: [8086:8c12] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3: [8086:8c16] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4: [8086:8c18] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1d.0: reg 0x10: [mem 0xfb812000-0xfb8123ff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1f.0: [8086:8c54] type 00 class 0x060100
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1f.3: reg 0x10: [mem 0xfb811000-0xfb8110ff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1f.6: [8086:8c24] type 00 class 0x118000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1f.6: reg 0x10: [mem 0xfb810000-0xfb810fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: acpiphp: Slot [0] registered
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:01:00.0: [8086:f1a5] type 00 class 0x010802
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:01:00.0: reg 0x10: [mem 0xfb700000-0xfb703fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.0:   bridge window [mem 0xfb700000-0xfb7fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:03:00.0: [8086:6f50] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:03:00.0: reg 0x10: [mem 0xfb606000-0xfb607fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:03:00.1: [8086:6f51] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:03:00.1: reg 0x10: [mem 0xfb604000-0xfb605fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:03:00.2: [8086:6f52] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:03:00.2: reg 0x10: [mem 0xfb602000-0xfb603fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:03:00.3: [8086:6f53] type 00 class 0x088000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:03:00.3: reg 0x10: [mem 0xfb600000-0xfb601fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.0: PCI bridge to [bus 03]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: [8086:15ac] type 00 class 0x020000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: reg 0x10: [mem 0xfbc00000-0xfbdfffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: reg 0x20: [mem 0xfbe04000-0xfbe07fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: reg 0x30: [mem 0xfb580000-0xfb5fffff pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR3 for 64 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: [8086:15ac] type 00 class 0x020000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: reg 0x10: [mem 0xfba00000-0xfbbfffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: reg 0x20: [mem 0xfbe00000-0xfbe03fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: reg 0x30: [mem 0xfb500000-0xfb57ffff pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR3 for 64 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2: PCI bridge to [bus 04]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2:   bridge window [mem 0xfb500000-0xfb5fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2:   bridge window [mem 0xfba00000-0xfbefffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0: [10b5:8112] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0: enabling Extended Tags
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0: PCI bridge to [bus 05-06]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0:   bridge window [mem 0xfb400000-0xfb4fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:06: extended config space not accessible
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.0: [1415:9501] type 00 class 0x070006
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.0: reg 0x10: [io  0xe0e0-0xe0ff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.0: reg 0x14: [mem 0xfb407000-0xfb407fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.0: reg 0x18: [io  0xe0c0-0xe0df]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.0: reg 0x1c: [mem 0xfb406000-0xfb406fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.0: supports D2
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.0: PME# supported from D0 D2 D3hot
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.1: [1415:9500] type 00 class 0x068000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.1: reg 0x10: [io  0xe0a0-0xe0bf]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.1: reg 0x14: [mem 0xfb405000-0xfb405fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.1: reg 0x18: [io  0xe080-0xe09f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.1: reg 0x1c: [mem 0xfb404000-0xfb404fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.1: supports D2
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:00.1: PME# supported from D0 D2 D3hot
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.0: [1415:9501] type 00 class 0x070006
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.0: reg 0x10: [io  0xe060-0xe07f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.0: reg 0x14: [mem 0xfb403000-0xfb403fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.0: reg 0x18: [io  0xe040-0xe05f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.0: reg 0x1c: [mem 0xfb402000-0xfb402fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.0: supports D2
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.0: PME# supported from D0 D2 D3hot
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.1: [1415:9500] type 00 class 0x068000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.1: reg 0x10: [io  0xe020-0xe03f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.1: reg 0x14: [mem 0xfb401000-0xfb401fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.1: reg 0x18: [io  0xe000-0xe01f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.1: reg 0x1c: [mem 0xfb400000-0xfb400fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.1: supports D2
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:06:01.1: PME# supported from D0 D2 D3hot
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0: PCI bridge to [bus 06]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0:   bridge window [io  0xe000-0xefff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0:   bridge window [mem 0xfb400000-0xfb4fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.2: PCI bridge to [bus 07]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:08:00.0: [8086:1533] type 00 class 0x020000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:08:00.0: reg 0x10: [mem 0xfb300000-0xfb37ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:08:00.0: reg 0x18: [io  0xd000-0xd01f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:08:00.0: reg 0x1c: [mem 0xfb380000-0xfb383fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0: PCI bridge to [bus 08]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0:   bridge window [mem 0xfb300000-0xfb3fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:09:00.0: [8086:1533] type 00 class 0x020000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:09:00.0: reg 0x10: [mem 0xfb200000-0xfb27ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:09:00.0: reg 0x18: [io  0xc000-0xc01f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:09:00.0: reg 0x1c: [mem 0xfb280000-0xfb283fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1: PCI bridge to [bus 09]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1:   bridge window [mem 0xfb200000-0xfb2fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0: [1a03:1150] type 01 class 0x060400
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0: enabling Extended Tags
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0: supports D1 D2
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3: PCI bridge to [bus 0a-0b]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3:   bridge window [io  0xb000-0xbfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3:   bridge window [mem 0xfa000000-0xfb0fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:0b: extended config space not accessible
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: [1a03:2000] type 00 class 0x030000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: reg 0x14: [mem 0xfb000000-0xfb01ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: reg 0x18: [io  0xb000-0xb07f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: BAR 0: assigned to efifb
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: supports D1 D2
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0: PCI bridge to [bus 0b]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0:   bridge window [io  0xb000-0xbfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0:   bridge window [mem 0xfa000000-0xfb0fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: [8086:1521] type 00 class 0x020000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: reg 0x10: [mem 0xfb160000-0xfb17ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: reg 0x18: [io  0xa060-0xa07f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: reg 0x1c: [mem 0xfb18c000-0xfb18ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR0 for 8 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR3 for 8 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: [8086:1521] type 00 class 0x020000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: reg 0x10: [mem 0xfb140000-0xfb15ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: reg 0x18: [io  0xa040-0xa05f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: reg 0x1c: [mem 0xfb188000-0xfb18bfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR0 for 8 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR3 for 8 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: [8086:1521] type 00 class 0x020000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: reg 0x10: [mem 0xfb120000-0xfb13ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: reg 0x18: [io  0xa020-0xa03f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: reg 0x1c: [mem 0xfb184000-0xfb187fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR0 for 8 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR3 for 8 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: [8086:1521] type 00 class 0x020000
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: reg 0x10: [mem 0xfb100000-0xfb11ffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: reg 0x18: [io  0xa000-0xa01f]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: reg 0x1c: [mem 0xfb180000-0xfb183fff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: PME# supported from D0 D3hot D3cold
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR0 for 8 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit pref] (contains BAR3 for 8 VFs)
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4: PCI bridge to [bus 0c]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4:   bridge window [io  0xa000-0xafff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4:   bridge window [mem 0xfb100000-0xfb1fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4: bridge has subordinate 0c but max busn 0d
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: on NUMA node 0
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 10 11 12)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 16 11:55:06 oob-pr10-y1 kernel: iommu: Default domain type: Translated 
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: vgaarb: setting as boot VGA device
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: vgaarb: bridge control possible
Sep 16 11:55:06 oob-pr10-y1 kernel: vgaarb: loaded
Sep 16 11:55:06 oob-pr10-y1 kernel: pps_core: LinuxPPS API ver. 1 registered
Sep 16 11:55:06 oob-pr10-y1 kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Sep 16 11:55:06 oob-pr10-y1 kernel: PTP clock support registered
Sep 16 11:55:06 oob-pr10-y1 kernel: EDAC MC: Ver: 3.0.0
Sep 16 11:55:06 oob-pr10-y1 kernel: Registered efivars operations
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI: Using ACPI for IRQ routing
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI: pci_cache_line_size set to 64 bytes
Sep 16 11:55:06 oob-pr10-y1 kernel: e820: reserve RAM buffer [mem 0x795d5000-0x7bffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: e820: reserve RAM buffer [mem 0x7989f000-0x7bffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: e820: reserve RAM buffer [mem 0x7bdb2000-0x7bffffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
Sep 16 11:55:06 oob-pr10-y1 kernel: hpet0: 8 comparators, 64-bit 14.318180 MHz counter
Sep 16 11:55:06 oob-pr10-y1 kernel: clocksource: Switched to clocksource tsc-early
Sep 16 11:55:06 oob-pr10-y1 kernel: VFS: Disk quotas dquot_6.6.0
Sep 16 11:55:06 oob-pr10-y1 kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Sep 16 11:55:06 oob-pr10-y1 kernel: AppArmor: AppArmor Filesystem Enabled
Sep 16 11:55:06 oob-pr10-y1 kernel: pnp: PnP ACPI init
Sep 16 11:55:06 oob-pr10-y1 kernel: pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [io  0x0500-0x057f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [io  0x0400-0x047f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [io  0x0580-0x059f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [io  0x0600-0x061f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [io  0x0880-0x0883] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [io  0x0800-0x081f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [mem 0xff000000-0xffffffff] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:02: [io  0x0a00-0x0a0f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:02: [io  0x0a10-0x0a1f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:02: [io  0x0a20-0x0a2f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:02: [io  0x0a30-0x0a3f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:02: [io  0x0a40-0x0a4f] has been reserved
Sep 16 11:55:06 oob-pr10-y1 kernel: system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
Sep 16 11:55:06 oob-pr10-y1 kernel: pnp 00:03: [dma 0 disabled]
Sep 16 11:55:06 oob-pr10-y1 kernel: pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
Sep 16 11:55:06 oob-pr10-y1 kernel: pnp 00:04: [dma 0 disabled]
Sep 16 11:55:06 oob-pr10-y1 kernel: pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
Sep 16 11:55:06 oob-pr10-y1 kernel: pnp: PnP ACPI: found 5 devices
Sep 16 11:55:06 oob-pr10-y1 kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Sep 16 11:55:06 oob-pr10-y1 kernel: NET: Registered protocol family 2
Sep 16 11:55:06 oob-pr10-y1 kernel: tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: TCP: Hash tables configured (established 65536 bind 65536)
Sep 16 11:55:06 oob-pr10-y1 kernel: UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
Sep 16 11:55:06 oob-pr10-y1 kernel: NET: Registered protocol family 1
Sep 16 11:55:06 oob-pr10-y1 kernel: NET: Registered protocol family 44
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: max bus depth: 2 pci_try_num: 3
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4: BAR 15: assigned [mem 0x90000000-0x900fffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.0:   bridge window [mem 0xfb700000-0xfb7fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.0: PCI bridge to [bus 03]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: BAR 7: no space for [mem size 0x00100000 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: BAR 7: failed to assign [mem size 0x00100000 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: BAR 10: no space for [mem size 0x00100000 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: BAR 10: failed to assign [mem size 0x00100000 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: BAR 7: no space for [mem size 0x00100000 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: BAR 7: failed to assign [mem size 0x00100000 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: BAR 10: no space for [mem size 0x00100000 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: BAR 10: failed to assign [mem size 0x00100000 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2: PCI bridge to [bus 04]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2:   bridge window [mem 0xfb500000-0xfb5fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2:   bridge window [mem 0xfba00000-0xfbefffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0: PCI bridge to [bus 06]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0:   bridge window [io  0xe000-0xefff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0:   bridge window [mem 0xfb400000-0xfb4fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0: PCI bridge to [bus 05-06]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0:   bridge window [mem 0xfb400000-0xfb4fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.2: PCI bridge to [bus 07]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0: PCI bridge to [bus 08]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0:   bridge window [mem 0xfb300000-0xfb3fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1: PCI bridge to [bus 09]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1:   bridge window [mem 0xfb200000-0xfb2fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0: PCI bridge to [bus 0b]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0:   bridge window [io  0xb000-0xbfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0:   bridge window [mem 0xfa000000-0xfb0fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3: PCI bridge to [bus 0a-0b]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3:   bridge window [io  0xb000-0xbfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3:   bridge window [mem 0xfa000000-0xfb0fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: BAR 7: assigned [mem 0x90000000-0x9001ffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.0: BAR 10: assigned [mem 0x90020000-0x9003ffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: BAR 7: assigned [mem 0x90040000-0x9005ffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.1: BAR 10: assigned [mem 0x90060000-0x9007ffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: BAR 7: assigned [mem 0x90080000-0x9009ffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.2: BAR 10: assigned [mem 0x900a0000-0x900bffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: BAR 7: assigned [mem 0x900c0000-0x900dffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0c:00.3: BAR 10: assigned [mem 0x900e0000-0x900fffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4: PCI bridge to [bus 0c]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4:   bridge window [io  0xa000-0xafff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4:   bridge window [mem 0xfb100000-0xfb1fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4:   bridge window [mem 0x90000000-0x900fffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: No. 2 try to assign unassigned res
Sep 16 11:55:06 oob-pr10-y1 kernel: release child resource [mem 0xfb500000-0xfb57ffff pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: release child resource [mem 0xfb580000-0xfb5fffff pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2: resource 14 [mem 0xfb500000-0xfb5fffff] released
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2: PCI bridge to [bus 04]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2: BAR 14: assigned [mem 0x90100000-0x905fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.0:   bridge window [mem 0xfb700000-0xfb7fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.0: PCI bridge to [bus 03]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: BAR 6: assigned [mem 0x90100000-0x9017ffff pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: BAR 6: assigned [mem 0x90180000-0x901fffff pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: BAR 7: assigned [mem 0x90200000-0x902fffff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.0: BAR 10: assigned [mem 0x90300000-0x903fffff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: BAR 7: assigned [mem 0x90400000-0x904fffff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:04:00.1: BAR 10: assigned [mem 0x90500000-0x905fffff 64bit]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2: PCI bridge to [bus 04]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2:   bridge window [mem 0x90100000-0x905fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:02.2:   bridge window [mem 0xfba00000-0xfbefffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0: PCI bridge to [bus 06]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0:   bridge window [io  0xe000-0xefff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:05:00.0:   bridge window [mem 0xfb400000-0xfb4fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0: PCI bridge to [bus 05-06]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.0:   bridge window [mem 0xfb400000-0xfb4fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:03.2: PCI bridge to [bus 07]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0: PCI bridge to [bus 08]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.0:   bridge window [mem 0xfb300000-0xfb3fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1: PCI bridge to [bus 09]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.1:   bridge window [mem 0xfb200000-0xfb2fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0: PCI bridge to [bus 0b]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0:   bridge window [io  0xb000-0xbfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0a:00.0:   bridge window [mem 0xfa000000-0xfb0fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3: PCI bridge to [bus 0a-0b]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3:   bridge window [io  0xb000-0xbfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.3:   bridge window [mem 0xfa000000-0xfb0fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4: PCI bridge to [bus 0c]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4:   bridge window [io  0xa000-0xafff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4:   bridge window [mem 0xfb100000-0xfb1fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1c.4:   bridge window [mem 0x90000000-0x900fffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:00: resource 7 [mem 0x90000000-0xfbffbfff window]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:01: resource 1 [mem 0xfb700000-0xfb7fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:03: resource 1 [mem 0xfb600000-0xfb6fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:04: resource 1 [mem 0x90100000-0x905fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:04: resource 2 [mem 0xfba00000-0xfbefffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:05: resource 1 [mem 0xfb400000-0xfb4fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:06: resource 1 [mem 0xfb400000-0xfb4fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:08: resource 0 [io  0xd000-0xdfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:08: resource 1 [mem 0xfb300000-0xfb3fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:09: resource 0 [io  0xc000-0xcfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:09: resource 1 [mem 0xfb200000-0xfb2fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:0a: resource 0 [io  0xb000-0xbfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:0a: resource 1 [mem 0xfa000000-0xfb0fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:0b: resource 0 [io  0xb000-0xbfff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:0b: resource 1 [mem 0xfa000000-0xfb0fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:0c: resource 0 [io  0xa000-0xafff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:0c: resource 1 [mem 0xfb100000-0xfb1fffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci_bus 0000:0c: resource 2 [mem 0x90000000-0x900fffff 64bit pref]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:05.0: disabled boot interrupts on device [8086:6f28]
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x643 took 22031 usecs
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x643 took 16170 usecs
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:01:00.0: CLS mismatch (64 != 32), using 64 bytes
Sep 16 11:55:06 oob-pr10-y1 kernel: pci 0000:0b:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Sep 16 11:55:06 oob-pr10-y1 kernel: Unpacking initramfs...
Sep 16 11:55:06 oob-pr10-y1 kernel: Freeing initrd memory: 11968K
Sep 16 11:55:06 oob-pr10-y1 kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Sep 16 11:55:06 oob-pr10-y1 kernel: software IO TLB: mapped [mem 0x70947000-0x74947000] (64MB)
Sep 16 11:55:06 oob-pr10-y1 kernel: Initialise system trusted keyrings
Sep 16 11:55:06 oob-pr10-y1 kernel: Key type blacklist registered
Sep 16 11:55:06 oob-pr10-y1 kernel: workingset: timestamp_bits=40 max_order=21 bucket_order=0
Sep 16 11:55:06 oob-pr10-y1 kernel: zbud: loaded
Sep 16 11:55:06 oob-pr10-y1 kernel: Key type asymmetric registered
Sep 16 11:55:06 oob-pr10-y1 kernel: Asymmetric key parser 'x509' registered
Sep 16 11:55:06 oob-pr10-y1 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
Sep 16 11:55:06 oob-pr10-y1 kernel: io scheduler mq-deadline registered
Sep 16 11:55:06 oob-pr10-y1 kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Sep 16 11:55:06 oob-pr10-y1 kernel: efifb: probing for efifb
Sep 16 11:55:06 oob-pr10-y1 kernel: efifb: framebuffer at 0xfa000000, using 1920k, total 1920k
Sep 16 11:55:06 oob-pr10-y1 kernel: efifb: mode is 800x600x32, linelength=3200, pages=1
Sep 16 11:55:06 oob-pr10-y1 kernel: efifb: scrolling: redraw
Sep 16 11:55:06 oob-pr10-y1 kernel: efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Sep 16 11:55:06 oob-pr10-y1 kernel: Console: switching to colour frame buffer device 100x37
Sep 16 11:55:06 oob-pr10-y1 kernel: fb0: EFI VGA frame buffer device
Sep 16 11:55:06 oob-pr10-y1 kernel: intel_idle: MWAIT substates: 0x2120
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: \_SB_.SCK0.CP00: Found 1 idle states
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: \_SB_.SCK0.CP01: Found 1 idle states
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: \_SB_.SCK0.CP02: Found 1 idle states
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: \_SB_.SCK0.CP03: Found 1 idle states
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: \_SB_.SCK0.CP04: Found 1 idle states
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: \_SB_.SCK0.CP05: Found 1 idle states
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: \_SB_.SCK0.CP06: Found 1 idle states
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: \_SB_.SCK0.CP07: Found 1 idle states
Sep 16 11:55:06 oob-pr10-y1 kernel: intel_idle: ACPI _CST not found or not usable
Sep 16 11:55:06 oob-pr10-y1 kernel: intel_idle: v0.5.1 model 0x56
Sep 16 11:55:06 oob-pr10-y1 kernel: intel_idle: Local APIC timer is reliable in all C-states
Sep 16 11:55:06 oob-pr10-y1 kernel: ERST: Error Record Serialization Table (ERST) support is initialized.
Sep 16 11:55:06 oob-pr10-y1 kernel: pstore: Registered erst as persistent store backend
Sep 16 11:55:06 oob-pr10-y1 kernel: GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
Sep 16 11:55:06 oob-pr10-y1 kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
Sep 16 11:55:06 oob-pr10-y1 kernel: 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: serial 0000:06:00.0: enabling device (0100 -> 0103)
Sep 16 11:55:06 oob-pr10-y1 kernel: 0000:06:00.0: ttyS4 at I/O 0xe0e0 (irq = 16, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: 0000:06:00.0: ttyS5 at I/O 0xe0e8 (irq = 16, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: 0000:06:00.0: ttyS6 at I/O 0xe0f0 (irq = 16, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: 0000:06:00.0: ttyS7 at I/O 0xe0f8 (irq = 16, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: serial 0000:06:01.0: enabling device (0100 -> 0103)
Sep 16 11:55:06 oob-pr10-y1 kernel: 0000:06:01.0: ttyS8 at I/O 0xe060 (irq = 17, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: 0000:06:01.0: ttyS9 at I/O 0xe068 (irq = 17, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: 0000:06:01.0: ttyS10 at I/O 0xe070 (irq = 17, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: 0000:06:01.0: ttyS11 at I/O 0xe078 (irq = 17, base_baud = 115200) is a 16550A
Sep 16 11:55:06 oob-pr10-y1 kernel: Linux agpgart interface v0.103
Sep 16 11:55:06 oob-pr10-y1 kernel: AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
Sep 16 11:55:06 oob-pr10-y1 kernel: AMD-Vi: AMD IOMMUv2 functionality not available on this system
Sep 16 11:55:06 oob-pr10-y1 kernel: i8042: PNP: No PS/2 controller found.
Sep 16 11:55:06 oob-pr10-y1 kernel: mousedev: PS/2 mouse device common for all mice
Sep 16 11:55:06 oob-pr10-y1 kernel: rtc_cmos 00:00: RTC can wake from S4
Sep 16 11:55:06 oob-pr10-y1 kernel: rtc_cmos 00:00: registered as rtc0
Sep 16 11:55:06 oob-pr10-y1 kernel: rtc_cmos 00:00: setting system clock to 2020-09-16T09:55:01 UTC (1600250101)
Sep 16 11:55:06 oob-pr10-y1 kernel: rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
Sep 16 11:55:06 oob-pr10-y1 kernel: intel_pstate: Intel P-state driver initializing
Sep 16 11:55:06 oob-pr10-y1 kernel: ledtrig-cpu: registered to indicate activity on CPUs
Sep 16 11:55:06 oob-pr10-y1 kernel: NET: Registered protocol family 10
Sep 16 11:55:06 oob-pr10-y1 kernel: Segment Routing with IPv6
Sep 16 11:55:06 oob-pr10-y1 kernel: mip6: Mobile IPv6
Sep 16 11:55:06 oob-pr10-y1 kernel: NET: Registered protocol family 17
Sep 16 11:55:06 oob-pr10-y1 kernel: mpls_gso: MPLS GSO support
Sep 16 11:55:06 oob-pr10-y1 kernel: microcode: sig=0x50663, pf=0x10, revision=0x7000019
Sep 16 11:55:06 oob-pr10-y1 kernel: microcode: Microcode Update Driver: v2.2.
Sep 16 11:55:06 oob-pr10-y1 kernel: IPI shorthand broadcast: enabled
Sep 16 11:55:06 oob-pr10-y1 kernel: sched_clock: Marking stable (3842615950, 976582690)->(6535220410, -1716021770)
Sep 16 11:55:06 oob-pr10-y1 kernel: registered taskstats version 1
Sep 16 11:55:06 oob-pr10-y1 kernel: Loading compiled-in X.509 certificates
Sep 16 11:55:06 oob-pr10-y1 kernel: zswap: loaded using pool lzo/zbud
Sep 16 11:55:06 oob-pr10-y1 kernel: pstore: Using crash dump compression: deflate
Sep 16 11:55:06 oob-pr10-y1 kernel: AppArmor: AppArmor sha1 policy hashing enabled
Sep 16 11:55:06 oob-pr10-y1 kernel: Freeing unused kernel image (initmem) memory: 1604K
Sep 16 11:55:06 oob-pr10-y1 kernel: Write protecting the kernel read-only data: 16384k
Sep 16 11:55:06 oob-pr10-y1 kernel: Freeing unused kernel image (text/rodata gap) memory: 2044K
Sep 16 11:55:06 oob-pr10-y1 kernel: Freeing unused kernel image (rodata/data gap) memory: 452K
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/mm: Checking user space page tables
Sep 16 11:55:06 oob-pr10-y1 kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Sep 16 11:55:06 oob-pr10-y1 kernel: Run /init as init process
Sep 16 11:55:06 oob-pr10-y1 kernel:   with arguments:
Sep 16 11:55:06 oob-pr10-y1 kernel:     /init
Sep 16 11:55:06 oob-pr10-y1 kernel:     noplymouth
Sep 16 11:55:06 oob-pr10-y1 kernel:   with environment:
Sep 16 11:55:06 oob-pr10-y1 kernel:     HOME=/
Sep 16 11:55:06 oob-pr10-y1 kernel:     TERM=linux
Sep 16 11:55:06 oob-pr10-y1 kernel:     BOOT_IMAGE=/boot/vmlinuz-5.8.9
Sep 16 11:55:06 oob-pr10-y1 kernel:     biosdevname=0
Sep 16 11:55:06 oob-pr10-y1 kernel: process '/usr/bin/sh' started with executable stack
Sep 16 11:55:06 oob-pr10-y1 kernel: t10_pi: module verification failed: signature and/or required key missing - tainting kernel
Sep 16 11:55:06 oob-pr10-y1 kernel: dca service started, version 1.12.1
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042F conflicts with OpRegion 0x0000000000000428-0x000000000000042F (\GPE0) (20200528/utaddress-213)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052F conflicts with OpRegion 0x000000000000052C-0x000000000000052D (\GPIV) (20200528/utaddress-213)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Sep 16 11:55:06 oob-pr10-y1 kernel: lpc_ich: Resource conflict(s) found affecting gpio_ich
Sep 16 11:55:06 oob-pr10-y1 kernel: tsc: Refined TSC clocksource calibration: 2199.998 MHz
Sep 16 11:55:06 oob-pr10-y1 kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb63109b96, max_idle_ns: 440795265316 ns
Sep 16 11:55:06 oob-pr10-y1 kernel: clocksource: Switched to clocksource tsc
Sep 16 11:55:06 oob-pr10-y1 kernel: igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
Sep 16 11:55:06 oob-pr10-y1 kernel: igb: Copyright (c) 2007-2014 Intel Corporation.
Sep 16 11:55:06 oob-pr10-y1 kernel: i801_smbus 0000:00:1f.3: enabling device (0000 -> 0003)
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI: bus type USB registered
Sep 16 11:55:06 oob-pr10-y1 kernel: i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
Sep 16 11:55:06 oob-pr10-y1 kernel: usbcore: registered new interface driver usbfs
Sep 16 11:55:06 oob-pr10-y1 kernel: i2c i2c-0: 1/4 memory slots populated (from DMI)
Sep 16 11:55:06 oob-pr10-y1 kernel: usbcore: registered new interface driver hub
Sep 16 11:55:06 oob-pr10-y1 kernel: usbcore: registered new device driver usb
Sep 16 11:55:06 oob-pr10-y1 kernel: pps pps0: new PPS source ptp0
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:08:00.0: added PHC on eth0
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:08:00.0: Intel(R) Gigabit Ethernet Network Connection
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe: Copyright (c) 1999-2016 Intel Corporation.
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:08:00.0: eth0: (PCIe:2.5Gb/s:Width x1) ac:1f:6b:1e:53:d6
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:08:00.0: eth0: PBA No: 010C00-000
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:08:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI Warning: \_SB.PCI0.BR2C._PRT: Return Package has no elements (empty) (20200528/nsprepkg-96)
Sep 16 11:55:06 oob-pr10-y1 kernel: nvme nvme0: pci function 0000:01:00.0
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci: EHCI PCI platform driver
Sep 16 11:55:06 oob-pr10-y1 kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Sep 16 11:55:06 oob-pr10-y1 kernel: nvme nvme0: 8/0/0 default/read/poll queues
Sep 16 11:55:06 oob-pr10-y1 kernel:  nvme0n1: p1 p2 p3
Sep 16 11:55:06 oob-pr10-y1 kernel: pmd_set_huge: Cannot satisfy [mem 0xfbc00000-0xfbe00000] with a huge-page mapping due to MTRR override.
Sep 16 11:55:06 oob-pr10-y1 kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
Sep 16 11:55:06 oob-pr10-y1 kernel: pps pps1: new PPS source ptp1
Sep 16 11:55:06 oob-pr10-y1 kernel: xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
Sep 16 11:55:06 oob-pr10-y1 kernel: xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:09:00.0: added PHC on eth1
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:09:00.0: Intel(R) Gigabit Ethernet Network Connection
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:09:00.0: eth1: (PCIe:2.5Gb/s:Width x1) ac:1f:6b:1e:53:d7
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:09:00.0: eth1: PBA No: 010000-000
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:09:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.08
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb1: Product: xHCI Host Controller
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb1: Manufacturer: Linux 5.8.9 xhci-hcd
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb1: SerialNumber: 0000:00:14.0
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 1-0:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 1-0:1.0: 8 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1a.0: EHCI Host Controller
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 2
Sep 16 11:55:06 oob-pr10-y1 kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Sep 16 11:55:06 oob-pr10-y1 kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1a.0: debug port 2
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.0: added PHC on eth2
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.0: Intel(R) Gigabit Ethernet Network Connection
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.0: eth2: (PCIe:5.0Gb/s:Width x4) ac:1f:6b:1e:53:d8
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.0: eth2: PBA No: 010000-000
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
Sep 16 11:55:06 oob-pr10-y1 kernel: xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.08
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb3: Product: xHCI Host Controller
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb3: Manufacturer: Linux 5.8.9 xhci-hcd
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb3: SerialNumber: 0000:00:14.0
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1a.0: irq 18, io mem 0xfb813000
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 3-0:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 3-0:1.0: 6 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.08
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb2: Product: EHCI Host Controller
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb2: Manufacturer: Linux 5.8.9 ehci_hcd
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb2: SerialNumber: 0000:00:1a.0
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 2-0:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 2-0:1.0: 2 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1d.0: EHCI Host Controller
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1d.0: debug port 2
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1d.0: irq 18, io mem 0xfb812000
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.1: added PHC on eth3
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.1: Intel(R) Gigabit Ethernet Network Connection
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.1: eth3: (PCIe:5.0Gb/s:Width x4) ac:1f:6b:1e:53:d9
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.1: eth3: PBA No: 010000-000
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.2: added PHC on eth4
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.2: Intel(R) Gigabit Ethernet Network Connection
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.2: eth4: (PCIe:5.0Gb/s:Width x4) ac:1f:6b:1e:53:da
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.2: eth4: PBA No: 010000-000
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.2: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-3: new high-speed USB device number 2 using xhci_hcd
Sep 16 11:55:06 oob-pr10-y1 kernel: ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.08
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb4: Product: EHCI Host Controller
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb4: Manufacturer: Linux 5.8.9 ehci_hcd
Sep 16 11:55:06 oob-pr10-y1 kernel: usb usb4: SerialNumber: 0000:00:1d.0
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 4-0:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 4-0:1.0: 2 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.3: added PHC on eth5
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.3: Intel(R) Gigabit Ethernet Network Connection
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.3: eth5: (PCIe:5.0Gb/s:Width x4) ac:1f:6b:1e:53:db
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.3: eth5: PBA No: 010000-000
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.3: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:09:00.0 eno2: renamed from eth1
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-3: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=32.98
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:08:00.0 eno1: renamed from eth0
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-3: Product: USB2.0 Hub
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 2-1: new high-speed USB device number 2 using ehci-pci
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 1-3:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 1-3:1.0: 4 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.0 eno3: renamed from eth2
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.1 eno4: renamed from eth3
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.2 eno5: renamed from eth4
Sep 16 11:55:06 oob-pr10-y1 kernel: igb 0000:0c:00.3 eno6: renamed from eth5
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-4: new high-speed USB device number 3 using xhci_hcd
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 2-1: New USB device found, idVendor=8087, idProduct=8008, bcdDevice= 0.05
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 2-1:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 2-1:1.0: 4 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.0: Multiqueue Enabled: Rx Queue count = 8, Tx Queue count = 8 XDP Queue count = 0
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 4-1: new high-speed USB device number 2 using ehci-pci
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-4: New USB device found, idVendor=0557, idProduct=7000, bcdDevice= 0.00
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 1-4:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 1-4:1.0: 4 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.0: MAC: 5, PHY: 0, PBA No: 020B00-000
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.0: ac:1f:6b:1e:56:2a
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 4-1: New USB device found, idVendor=8087, idProduct=8000, bcdDevice= 0.05
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-3.2: new high-speed USB device number 4 using xhci_hcd
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 4-1:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 4-1:1.0: 4 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-3.2: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=32.98
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-3.2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-3.2: Product: USB2.0 Hub
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 1-3.2:1.0: USB hub found
Sep 16 11:55:06 oob-pr10-y1 kernel: hub 1-3.2:1.0: 4 ports detected
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-4.1: new low-speed USB device number 5 using xhci_hcd
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.0: Intel(R) 10 Gigabit Network Connection
Sep 16 11:55:06 oob-pr10-y1 kernel: libphy: ixgbe-mdio: probed
Sep 16 11:55:06 oob-pr10-y1 kernel: ACPI Warning: \_SB.PCI0.BR2C._PRT: Return Package has no elements (empty) (20200528/nsprepkg-96)
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-4.1: New USB device found, idVendor=0557, idProduct=2419, bcdDevice= 1.00
Sep 16 11:55:06 oob-pr10-y1 kernel: usb 1-4.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Sep 16 11:55:06 oob-pr10-y1 kernel: hid: raw HID events driver (C) Jiri Kosina
Sep 16 11:55:06 oob-pr10-y1 kernel: usbcore: registered new interface driver usbhid
Sep 16 11:55:06 oob-pr10-y1 kernel: usbhid: USB HID core driver
Sep 16 11:55:06 oob-pr10-y1 kernel: input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0/0003:0557:2419.0001/input/input0
Sep 16 11:55:06 oob-pr10-y1 kernel: hid-generic 0003:0557:2419.0001: input,hidraw0: USB HID v1.00 Keyboard [HID 0557:2419] on usb-0000:00:14.0-4.1/input0
Sep 16 11:55:06 oob-pr10-y1 kernel: input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.1/0003:0557:2419.0002/input/input1
Sep 16 11:55:06 oob-pr10-y1 kernel: hid-generic 0003:0557:2419.0002: input,hidraw1: USB HID v1.00 Mouse [HID 0557:2419] on usb-0000:00:14.0-4.1/input1
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.1: Multiqueue Enabled: Rx Queue count = 8, Tx Queue count = 8 XDP Queue count = 0
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.1: MAC: 5, PHY: 19, SFP+: 12, PBA No: 020B00-000
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.1: ac:1f:6b:1e:56:2b
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.1: Intel(R) 10 Gigabit Network Connection
Sep 16 11:55:06 oob-pr10-y1 kernel: libphy: ixgbe-mdio: probed
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.1 eno8: renamed from eth1
Sep 16 11:55:06 oob-pr10-y1 kernel: ixgbe 0000:04:00.0 eno7: renamed from eth0
Sep 16 11:55:06 oob-pr10-y1 kernel: device-mapper: uevent: version 1.0.3
Sep 16 11:55:06 oob-pr10-y1 kernel: device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
Sep 16 11:55:06 oob-pr10-y1 kernel: PM: Image not found (code -22)
Sep 16 11:55:06 oob-pr10-y1 kernel: EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
Sep 16 11:55:06 oob-pr10-y1 kernel: Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Inserted module 'autofs4'
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Detected architecture x86-64.
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Set hostname to <oob-pr10-y1>.
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Listening on initctl Compatibility Named Pipe.
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Listening on fsck to fsckd communication Socket.
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Created slice system-postfix.slice.
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Listening on Journal Socket (/dev/log).
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Listening on udev Control Socket.
Sep 16 11:55:06 oob-pr10-y1 systemd[1]: Created slice system-serial\x2dmonitor.slice.
Sep 16 11:55:06 oob-pr10-y1 kernel: EXT4-fs (dm-0): re-mounted. Opts: discard,errors=remount-ro
Sep 16 11:55:07 oob-pr10-y1 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
Sep 16 11:55:07 oob-pr10-y1 kernel: ACPI: Power Button [PWRB]
Sep 16 11:55:07 oob-pr10-y1 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
Sep 16 11:55:07 oob-pr10-y1 kernel: ACPI: Power Button [PWRF]
Sep 16 11:55:07 oob-pr10-y1 kernel: IPMI message handler: version 39.2
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi device interface
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si: IPMI System Interface driver
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si: Adding SMBIOS-specified kcs state machine
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca2] regsize 1 spacing 1 irq 0
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si: Adding ACPI-specified kcs state machine
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
Sep 16 11:55:07 oob-pr10-y1 kernel: ioatdma: Intel(R) QuickData Technology Driver 5.00
Sep 16 11:55:07 oob-pr10-y1 kernel: ioatdma 0000:03:00.0: enabling device (0104 -> 0106)
Sep 16 11:55:07 oob-pr10-y1 kernel: iTCO_vendor_support: vendor-support=0
Sep 16 11:55:07 oob-pr10-y1 kernel: mei_me 0000:00:16.0: Device doesn't have valid ME Interface
Sep 16 11:55:07 oob-pr10-y1 kernel: ioatdma 0000:03:00.1: enabling device (0104 -> 0106)
Sep 16 11:55:07 oob-pr10-y1 kernel: iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
Sep 16 11:55:07 oob-pr10-y1 kernel: iTCO_wdt: Found a Lynx Point TCO device (Version=2, TCOBASE=0x0460)
Sep 16 11:55:07 oob-pr10-y1 kernel: iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
Sep 16 11:55:07 oob-pr10-y1 kernel: ioatdma 0000:03:00.2: enabling device (0104 -> 0106)
Sep 16 11:55:07 oob-pr10-y1 kernel: ioatdma 0000:03:00.3: enabling device (0104 -> 0106)
Sep 16 11:55:07 oob-pr10-y1 kernel: EFI Variables Facility v0.08 2004-May-17
Sep 16 11:55:07 oob-pr10-y1 kernel: checking generic (fa000000 1e0000) vs hw (fa000000 1000000)
Sep 16 11:55:07 oob-pr10-y1 kernel: fb0: switching to astdrmfb from EFI VGA
Sep 16 11:55:07 oob-pr10-y1 kernel: Console: switching to colour dummy device 80x25
Sep 16 11:55:07 oob-pr10-y1 kernel: [drm] Using P2A bridge for configuration
Sep 16 11:55:07 oob-pr10-y1 kernel: [drm] AST 2400 detected
Sep 16 11:55:07 oob-pr10-y1 kernel: [drm] Analog VGA only
Sep 16 11:55:07 oob-pr10-y1 kernel: [drm] dram MCLK=408 Mhz type=1 bus_width=16 size=01000000
Sep 16 11:55:07 oob-pr10-y1 kernel: [TTM] Zone  kernel: Available graphics memory: 4025316 KiB
Sep 16 11:55:07 oob-pr10-y1 kernel: [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
Sep 16 11:55:07 oob-pr10-y1 kernel: [TTM] Initializing pool allocator
Sep 16 11:55:07 oob-pr10-y1 kernel: [TTM] Initializing DMA pool allocator
Sep 16 11:55:07 oob-pr10-y1 kernel: [drm] Initialized ast 0.1.0 20120228 for 0000:0b:00.0 on minor 0
Sep 16 11:55:07 oob-pr10-y1 kernel: RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
Sep 16 11:55:07 oob-pr10-y1 kernel: RAPL PMU: hw unit of domain package 2^-14 Joules
Sep 16 11:55:07 oob-pr10-y1 kernel: RAPL PMU: hw unit of domain dram 2^-16 Joules
Sep 16 11:55:07 oob-pr10-y1 kernel: pstore: ignoring unexpected backend 'efi'
Sep 16 11:55:07 oob-pr10-y1 kernel: cryptd: max_cpu_qlen set to 1000
Sep 16 11:55:07 oob-pr10-y1 kernel: fbcon: astdrmfb (fb0) is primary device
Sep 16 11:55:07 oob-pr10-y1 kernel: AVX2 version of gcm_enc/dec engaged.
Sep 16 11:55:07 oob-pr10-y1 kernel: AES CTR mode by8 optimization enabled
Sep 16 11:55:07 oob-pr10-y1 kernel: Console: switching to colour frame buffer device 128x48
Sep 16 11:55:07 oob-pr10-y1 kernel: ast 0000:0b:00.0: fb0: astdrmfb frame buffer device
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fa0
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fa0
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f60
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fa8
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fa8
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f71
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f71
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6faa
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6faa
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fab
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fab
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fac
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fac
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fad
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6fad
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f68
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f79
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f6a
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f6b
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f6c
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6f6d
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6ffc
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6ffc
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6ffd
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6ffd
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6faf
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge: Seeking for: PCI ID 8086:6faf
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC MC0: Giving out device to module sb_edac controller Broadwell SrcID#0_Ha#0: DEV 0000:ff:12.0 (INTERRUPT)
Sep 16 11:55:07 oob-pr10-y1 kernel: EDAC sbridge:  Ver: 1.1.2 
Sep 16 11:55:07 oob-pr10-y1 kernel: intel_rapl_common: Found RAPL domain package
Sep 16 11:55:07 oob-pr10-y1 kernel: intel_rapl_common: Found RAPL domain dram
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
Sep 16 11:55:07 oob-pr10-y1 kernel: Adding 3997692k swap on /dev/mapper/vg00-swap_1.  Priority:-2 extents:1 across:3997692k SSFS
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x002a7c, prod_id: 0x0921, dev_id: 0x20)
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_si IPI0001:00: IPMI kcs interface initialized
Sep 16 11:55:07 oob-pr10-y1 kernel: ipmi_ssif: IPMI SSIF Interface driver
Sep 16 11:55:09 oob-pr10-y1 kernel: pps pps2: new PPS source ptp6
Sep 16 11:55:09 oob-pr10-y1 kernel: ixgbe 0000:04:00.1: registered PHC device on eno8
Sep 16 11:55:09 oob-pr10-y1 kernel: ixgbe 0000:04:00.1 eno8: detected SFP+: 12
Sep 16 11:55:09 oob-pr10-y1 kernel: ixgbe 0000:04:00.1 eno8: NIC Link is Up 1 Gbps, Flow Control: RX/TX
Sep 16 11:55:09 oob-pr10-y1 kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eno8: link becomes ready
Sep 16 11:55:16 oob-pr10-y1 kernel: 8021q: 802.1Q VLAN Support v1.8
Sep 16 11:55:16 oob-pr10-y1 kernel: 8021q: adding VLAN 0 to HW filter on device eno1
Sep 16 11:55:16 oob-pr10-y1 kernel: 8021q: adding VLAN 0 to HW filter on device eno2
Sep 16 11:55:16 oob-pr10-y1 kernel: 8021q: adding VLAN 0 to HW filter on device eno8
Sep 16 11:55:16 oob-pr10-y1 kernel: br_vlan460: port 1(eno1) entered blocking state
Sep 16 11:55:16 oob-pr10-y1 kernel: br_vlan460: port 1(eno1) entered disabled state
Sep 16 11:55:16 oob-pr10-y1 kernel: device eno1 entered promiscuous mode
Sep 16 11:55:16 oob-pr10-y1 kernel: br_vlan460: port 2(eno2) entered blocking state
Sep 16 11:55:16 oob-pr10-y1 kernel: br_vlan460: port 2(eno2) entered disabled state
Sep 16 11:55:16 oob-pr10-y1 kernel: device eno2 entered promiscuous mode
Sep 16 11:55:16 oob-pr10-y1 kernel: br_vlan460: port 3(vlan460) entered blocking state
Sep 16 11:55:16 oob-pr10-y1 kernel: br_vlan460: port 3(vlan460) entered disabled state
Sep 16 11:55:16 oob-pr10-y1 kernel: device vlan460 entered promiscuous mode
Sep 16 11:55:16 oob-pr10-y1 kernel: device eno8 entered promiscuous mode
Sep 16 11:55:16 oob-pr10-y1 kernel: br_vlan460: port 3(vlan460) entered blocking state
Sep 16 11:55:16 oob-pr10-y1 kernel: br_vlan460: port 3(vlan460) entered forwarding state

--------------F39048ABA6B92B1707D476FE--
