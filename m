Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057982BFDFC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKWBLo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 22 Nov 2020 20:11:44 -0500
Received: from david.siemens.com.cn ([194.138.202.53]:44606 "EHLO
        david.siemens.com.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgKWBLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 20:11:44 -0500
Received: from mail.siemens.com.cn (mail.siemens.com.cn [194.138.237.52])
        by david.siemens.com.cn (8.14.9/8.14.9) with ESMTP id 0AN1BSHt020357
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 09:11:29 +0800
Received: from CNPEK01M02MSX.ad011.siemens.net (cnpek01m02msx.ad011.siemens.net [139.24.237.215])
        by mail.siemens.com.cn (8.14.9/8.14.9) with ESMTP id 0AN1BP1c018969
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 09:11:27 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 23 Nov 2020 09:11:24 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2106.003; Mon, 23 Nov 2020 09:11:24 +0800
From:   "Wang, Sheng Long" <shenglong.wang.ext@siemens.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Sheng Long Wang <china_shenglong@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: RE: [PATCH v6] usb-serial:cp210x: add support to software flow
 control
Thread-Topic: [PATCH v6] usb-serial:cp210x: add support to software flow
 control
Thread-Index: AQHWo2OeB9qO2j8ZGUeYQhba2pC/J6nF1h2AgAS8JjCAAA6LgIAKgkeg
Content-Class: 
Date:   Mon, 23 Nov 2020 01:11:24 +0000
Message-ID: <496f2cc77b4d4c3a9b49410ac318b927@siemens.com>
References: <20201016022428.9671-1-china_shenglong@163.com>
 <X66l44MqSlj774DL@localhost> <520e730958174cb39561a94d03e4727e@siemens.com>
 <X7Kq6fJ/VMnB3Nt0@localhost>
In-Reply-To: <X7Kq6fJ/VMnB3Nt0@localhost>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcejAwNDNjYnhcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jYmQyM2E0My0yZDI4LTExZWItYmU3MS1iMDBjZDE2OTA4NjRcYW1lLXRlc3RcY2JkMjNhNDUtMmQyOC0xMWViLWJlNzEtYjAwY2QxNjkwODY0Ym9keS50eHQiIHN6PSIyNjE1IiB0PSIxMzI1MDU2NzQ4MTY1NDU3NzIiIGg9IkN3bGFUMXFwZm93elYzbXYxZ0RzaGFQMlk2cz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUhBQUFBRHM0eW1PTmNIV0FTYTBwTHA3VkdjZ0pyU2t1bnRVWnlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUJBQUFBbytaL1dnQUFBQUFBQUFBQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2020-11-23T01:11:21Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=b5033c27-e2f5-4078-bcd5-2c1ba15bdcdd;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
x-originating-ip: [139.24.108.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Johan

Do I add my  software flow control  patch directly to the branch you gave me now ? 
https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=cp210x-termios

Then, I also need the cp210x_ get_ terminus()  add ixoff / iXon handling?

Thanks!


With best regards,
Wang Sheng Long
Siemens Ltd., China
RC-CN DI FA R&D SW
Tianyuan road No.99
611731 CHENGDU, China
Mobil: +86 15281074996
mailto:shenglong.wang.ext@siemens.com
www.siemens.com/ingenuityforlife


-----Original Message-----
From: Johan Hovold <johan@kernel.org> 
Sent: Tuesday, November 17, 2020 12:38 AM
To: Wang, Sheng Long (EXT) (RC-CN DI FA BL IPC&C PRC4) <shenglong.wang.ext@siemens.com>
Cc: Johan Hovold <johan@kernel.org>; Sheng Long Wang <china_shenglong@163.com>; gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; lkp@intel.com
Subject: Re: [PATCH v6] usb-serial:cp210x: add support to software flow control

[ Please avoid top posting. ]

On Mon, Nov 16, 2020 at 07:56:10AM +0000, Wang, Sheng Long wrote:
> Hi, Johan
> 
> Thank you very much for your reply!
> 
> You mean if we call cp210x_open()  When opening the device, because 
> IXON  is set by default, the cp210x_get_termios() does not process 
> IXON, So it is invalid IXON at this time.

Right, with the current implementation you need to make sure that termios reflects the device state on open or your changes will never actually enable software flow control in the device.

> As you said, It is very strange in cp210x_get_termios()  In the "get"
> function to "set"  IXON.  In addition, the best way is to disable the 
> IXON bit as you said.  If the user needs IXON, call set_ termios 
> function, So I'm now in cp210x_get_termios()  Is it a temporary 
> solution for terminos to handle IXON ?  I'm afraid it will need to be 
> adjusted.

No, I didn't mean that IXON should be disabled by default. I meant that the driver should make sure that the device settings matches termios on open, not the other way round.

This unusual implementation has caused a number of issues in the past and it's been on my list fix up for some time. I finally got around to that today and I just CCed you on the result. That should simplify adding software flow control and allow more code to be shared with the hardware flow-control handling.

I've pushed a branch for you here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=cp210x-termios

Johan
