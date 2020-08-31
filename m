Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A412257E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgHaQLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 12:11:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52800 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:11:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VGBPxr001999;
        Mon, 31 Aug 2020 16:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ZhCWexSMKNXu1MxtembjupZbaEUJ4elwPV+Hcdg5fzk=;
 b=AO9qIOE/Fs5ExYKo2uBxpD64CU0GRsyuLOyvwqDI5qDsmOyv2WPn0fj+gh2G/jehrJbm
 LzxAoUu+WfkisYewxOurRhMWZo9Xu03Kcr+RG+wnX0bW8uOwEuJtwUBSEl4lfBSlP5vj
 DV3CowJADVgbEvLDslQgJrrZr1vb3mtZZcM1zn15htL/QItzrqDDV/IDFMffEZ1mr0+z
 wg+fy4xkMF0kM/+U/zpgCYIDs98smdxAzrYm2eDb5NyG4TGXszWY7BtTBzLIn/68rpHg
 8LZJS8zkAVUSpY5bfd9xdA25IsD/sQElqO9/78fnt1H5MUs8Rv6HxcrRMvfrlmMRn6cs aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eyky46b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 16:11:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VG0x2V011563;
        Mon, 31 Aug 2020 16:09:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380sq79y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 16:09:21 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07VG9I4N032186;
        Mon, 31 Aug 2020 16:09:18 GMT
Received: from concerto.us.oracle.com (/10.65.179.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 09:09:17 -0700
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        erkka.talvitie@vincit.fi
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, inux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] USB EHCI: repeated resets on full and low speed devices
Date:   Mon, 31 Aug 2020 10:08:42 -0600
Message-Id: <cover.1598887346.git.khalid@gonehiking.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently replaced the motherboard on my desktop with an MSI B450-A
Pro Max motherboard. Since then my keybaords, mouse and tablet have
become very unreliable. I see messages like this over and over in
dmesg:

ug 23 00:01:49 rhapsody kernel: [198769.314732] usb 1-2.4: reset full-speed USB
 device number 27 using ehci-pci
Aug 23 00:01:49 rhapsody kernel: [198769.562234] usb 1-2.1: reset full-speed USB
 device number 28 using ehci-pci
Aug 23 00:01:52 rhapsody kernel: [198772.570704] usb 1-2.1: reset full-speed USB
 device number 28 using ehci-pci
Aug 23 00:02:02 rhapsody kernel: [198782.526669] usb 1-2.4: reset full-speed USB
 device number 27 using ehci-pci
Aug 23 00:02:03 rhapsody kernel: [198782.714660] usb 1-2.1: reset full-speed USB
 device number 28 using ehci-pci
Aug 23 00:02:04 rhapsody kernel: [198784.210171] usb 1-2.3: reset low-speed USB device number 26 using ehci-pci
Aug 23 00:02:06 rhapsody kernel: [198786.110181] usb 1-2.4: reset full-speed USB device number 27 using ehci-pci
Aug 23 00:02:08 rhapsody kernel: [198787.726158] usb 1-2.4: reset full-speed USB device number 27 using ehci-pci
Aug 23 00:02:10 rhapsody kernel: [198790.126628] usb 1-2.1: reset full-speed USB device number 28 using ehci-pci
Aug 23 00:02:10 rhapsody kernel: [198790.314141] usb 1-2.4: reset full-speed USB device number 27 using ehci-pci
Aug 23 00:02:12 rhapsody kernel: [198792.518765] usb 1-2.4: reset full-speed USB device number 27 using ehci-pci

The devices I am using are:

- Logitech K360 wireless keyboard
- Wired Lenovo USB keyboard
- Wired Lenovo USB mouse
- Wired Wacom Intuos tablet

After a reset, the wireless keyboard simply stops working. Rest of
the devices keep seeing intermittent failure.

I tried various combinations of hubs and USB controllers to see what
works. MSI B450-A motherboard has USB 3.0 and USB 3.1 controllers. I
added a USB 2.0 PCI card as well for this test:

03:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset USB 3.1 XHCI Controller (rev 01)
29:01.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
29:01.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
29:01.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04)
2c:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller

I have a bus powered USB 3.0 hub, a bus powered USB 2.0 hub and a
self powered USB 2.0 hub built into my monitor.

I have connected my devices directly into the ports on motherboard
and PCI card as well as into external hub. Here are the results I
saw when devices wee plugged into various combination of ports:

1. USB 3.0/3.1 controller - does NOT work
2. USB 2.0 controller - WORKS
3. USB 3.0/3.1 controller -> Self powered USB 2.0 hub in monitor - does
   NOT work
4. USB 3.0/3.1 controller -> bus powered USB 3.0 hub - does NOT work
5. USB 3.0/3.1 controller -> Bus powered USB 2.0 hub - WORKS
7. USB 2.0 controller -> Bus powered USB 3.0 hub - does NOT work
8. USB 2.0 controller -> Bus powered 2.0 hub - Does not work

I narrowed the failure down to following lines (this code was added
in 5.5 with commit 64cc3f12d1c7 "USB: EHCI: Do not return -EPIPE
when hub is disconnected"):

drivers/usb/host/ehci-q.c:

 217                 } else if ((token & QTD_STS_MMF) &&
 218                                         (QTD_PID(token) == PID_CODE_IN)) {
 219                         status = -EPROTO;
 220                 /* CERR nonzero + halt --> stall */

At the time of failure, when we reach this conditional, token is
either 0x80408d46 or 0x408d46 which means following bits are set:

QTD_STS_STS, QTD_STS_MMF, QTD_STS_HALT, QTD_IOC, QTD_TOGGLE

and 

        QTD_PID = 1
        QTD_CERR = 3
        QTD_LENGTH = 0x40 (64)

This causes  the branch "(token & QTD_STS_MMF) && (QTD_PID(token) ==
PID_CODE_IN" to be taken and qtd_copy_status() returns EPROTO. This
return value in qh_completions() results in ehci_clear_tt_buffer()
being called:

drivers/usb/host/ehci-q.c:
 472                         /* As part of low/full-speed endpoint-halt processi     ng
 473                          * we must clear the TT buffer (11.17.5).
 474                          */
 475                         if (unlikely(last_status != -EINPROGRESS &&
 476                                         last_status != -EREMOTEIO)) {
 477                                 /* The TT's in some hubs malfunction when t     hey
 478                                  * receive this request following a STALL (     they
 479                                  * stop sending isochronous packets).  Sinc     e a
 480                                  * STALL can't leave the TT buffer in a bus     y
 481                                  * state (if you believe Figures 11-48 - 11     -51
 482                                  * in the USB 2.0 spec), we won't clear the      TT
 483                                  * buffer in this case.  Strictly speaking      this
 484                                  * is a violation of the spec.
 485                                  */
 486                                 if (last_status != -EPIPE)
 487                                         ehci_clear_tt_buffer(ehci, qh, urb,
 488                                                         token);
 489                         }

It seems like clearing TT buffers in this case is resulting in hub
hanging. A USB reset gets it going again until we repeat the cycle
over again. The comment in this code says "The TT's in some hubs
malfunction when they receive this request following a STALL (they
stop sending isochronous packets)". That may be what is happening.

Removing the code that returns EPROTO for such case solves the
problem on my machine (as in the RFC patch) but that probably is not
the right solution. I do not understand USB protocol well enough to
propose a better solution. Does anyone have a better idea?


Khalid Aziz (1):
  usb: ehci: Remove erroneous return of EPROTO upon detection of stall 

 drivers/usb/host/ehci-q.c | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.25.1

