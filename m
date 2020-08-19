Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC0249823
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHSITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 04:19:46 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:56755 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSITp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:19:45 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 07J8JXwx010309
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 10:19:33 +0200
Received: from [167.87.31.209] ([167.87.31.209])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07J8JVu2005181;
        Wed, 19 Aug 2020 10:19:31 +0200
Subject: Re: [PATCH] usb-serial:cp210x: add support to software flow control
To:     china_shenglong <china_shenglong@163.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
References: <20200730075922.28041-1-china_shenglong@163.com>
 <20200730080639.GA216353@kroah.com>
 <386a30c0.ac88.1739eda0ee5.Coremail.china_shenglong@163.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <415e7692-7452-41bb-ec7a-e80c42aa8507@siemens.com>
Date:   Wed, 19 Aug 2020 10:19:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <386a30c0.ac88.1739eda0ee5.Coremail.china_shenglong@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.20 10:32, china_shenglong wrote:
> Hi, Greg
> 
> Yeah, It mainly adjusts the code style according to the kernel
> specification,
> and then modifies it according to your previous review comments.
> 
> Thanks,
> 
> BR/ Wang ShengLong
> 
> 
> At 2020-07-30 16:06:39, "Greg KH" <gregkh@linuxfoundation.org> wrote:
>>On Thu, Jul 30, 2020 at 03:59:22PM +0800, Sheng Long Wang wrote:
>>> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
>>> 
>>> When data is transmitted between two serial ports,
>>> the phenomenon of data loss often occurs. The two kinds
>>> of flow control commonly used in serial communication
>>> are hardware flow control and software flow control.
>>> 
>>> In serial communication, If you only use RX/TX/GND Pins, you
>>> can't do hardware flow. So we often used software flow control
>>> and prevent data loss. The user sets the software flow control
>>> through the application program, and the application program
>>> sets the software flow control mode for the serial port
>>> chip through the driver.
>>> 
>>> For the cp210 serial port chip, its driver lacks the
>>> software flow control setting code, so the user cannot set
>>> the software flow control function through the application
>>> program. This adds the missing software flow control.
>>> 
>>> Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
>>> ---
>>>  drivers/usb/serial/cp210x.c | 118 ++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 113 insertions(+), 5 deletions(-)
>>
>>What changed from the previous version of this patch?  That should be
>>described below the --- line and this is a v2, right?
>>
>>thanks,
>>
>>greg k-h

This no longer applies. Shenglong, could you send a rebased version as v3?
Please also include a changelog after the "---" separator this time.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
