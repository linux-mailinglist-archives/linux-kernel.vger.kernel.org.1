Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3EC26A661
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIONhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:37:23 -0400
Received: from node.akkea.ca ([192.155.83.177]:60636 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgIONbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:31:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id EA60B4E201F;
        Tue, 15 Sep 2020 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600176680; bh=gtj/Nyy1vtgEu5K98dpN7qFHnlOiZePDKix5OG62n4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=G7N5XllA2F0KoXYnkUIWeekxwQZWbcjAbVZ2Pz9by2aBkwVPtMmhPGCvm+JoyAeW7
         ojfCI+dKYiUfl/XPT7pKaDzyQTEFsN8iX58neF14cGwqz2RCjAMXDd3IG9LLMhIHua
         qDoBiMFOSm2GErjLDcX0yJmW/+vkvNfm8LI4Qys8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UcZR_BcROKHC; Tue, 15 Sep 2020 13:31:19 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 41C234E200E;
        Tue, 15 Sep 2020 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600176679; bh=gtj/Nyy1vtgEu5K98dpN7qFHnlOiZePDKix5OG62n4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=IMtXG/QJAiy5UTRY3xSVaQZTEpcnB0yr7fBviRru58vV7DxGdKBwObJl3Gi11KlhT
         NHFsthA5w6Mt9tft3X0ETH+j2UbzG4I3Wi84zJqqqKUb/A4jXGtd/fSbatDR7sMId5
         ovN34oXI2jHPSh1w8wIQFTo3dJsRjwjWKRoLOJjs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 06:31:19 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kernel@puri.sm, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: Re: [PATCH 1/4] extcon: Add USB VBUS properties
In-Reply-To: <bfa20bf2-e13b-1cd4-52d9-c8fa922d5aac@samsung.com>
References: <20200914164639.1487650-1-angus@akkea.ca>
 <CGME20200914165800epcas1p12e04260289513eac00f442388d5ba374@epcas1p1.samsung.com>
 <20200914164639.1487650-2-angus@akkea.ca>
 <bfa20bf2-e13b-1cd4-52d9-c8fa922d5aac@samsung.com>
Message-ID: <23ce56387f39fa097b36380dbe9661a0@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-09-14 18:40, Chanwoo Choi wrote:
> Hi,
> 
> On 9/15/20 1:46 AM, Angus Ainslie wrote:
>> USB type C, USB BC1.2 and USB power delivery allow different voltages
>> and currents for VBUS so we need these additional properties.
>> 
>> Also USB type C allows separate device and power roles so add a VBUS 
>> SRC
>> property.
>> 
>> Signed-off-by: Angus Ainslie <angus@akkea.ca>
>> ---
>>  include/linux/extcon.h | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
>> index fd183fb9c20f..c4d48f4f74c4 100644
>> --- a/include/linux/extcon.h
>> +++ b/include/linux/extcon.h
>> @@ -117,14 +117,29 @@
>>   * @type:       integer (intval)
>>   * @value:      0 (USB/USB2) or 1 (USB3)
>>   * @default:    0 (USB/USB2)
>> + * - EXTCON_PROP_USB_VBUS_SRC
> 
> Could you explain more correct meaning of both sink and source?
> 

Sure I can add some comments.

>> + * @type:	integer (intval)
>> + * @value:	0 (sink) or 1 (source)
>> + * @default:	0 (sink)
>> + * - EXTCON_PROP_USB_VBUS_VOLTAGE
>> + * @type:	integer (intval)
>> + * @value:	negotiated vbus voltage in mV
>> + * @default:	5000
> 
> Could you suggest the data why do you set default value as 5000?
> 

The lowest USB VBUS is 5V so I can add that to the comments.

>> + * - EXTCON_PROP_USB_VBUS_CURRENT
>> + * @type:	integer (intval)
>> + * @value:	negotiated vbus current in mA
>> + * @default:	100
> 
> ditto. Why default value is 100?
> 

USB spec says that until the current is negotiated the max that anything 
can draw is 100mA. I can add a comment to that effect.

Thanks
Angus

>>   *
>>   */
>>  #define EXTCON_PROP_USB_VBUS		0
>>  #define EXTCON_PROP_USB_TYPEC_POLARITY	1
>>  #define EXTCON_PROP_USB_SS		2
>> +#define EXTCON_PROP_USB_VBUS_SRC	3
>> +#define EXTCON_PROP_USB_VBUS_VOLTAGE	4
>> +#define EXTCON_PROP_USB_VBUS_CURRENT	5
>> 
>>  #define EXTCON_PROP_USB_MIN		0
>> -#define EXTCON_PROP_USB_MAX		2
>> +#define EXTCON_PROP_USB_MAX		5
>>  #define EXTCON_PROP_USB_CNT	(EXTCON_PROP_USB_MAX - 
>> EXTCON_PROP_USB_MIN + 1)
>> 
>>  /* Properties of EXTCON_TYPE_CHG. */
>> 
