Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32413274B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIVVVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:21:30 -0400
Received: from node.akkea.ca ([192.155.83.177]:48000 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIVVVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:21:30 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 17:21:30 EDT
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 6EBFF4E2010;
        Tue, 22 Sep 2020 21:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600809331; bh=VUGrSclU1XhJlSqt4y7Ch9vosKRFqpaAskysoliTNms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Wup8Z4HMpjDujueL03kwleUiePN0hk5QSWMIsEAEnJ3BYF25+5HyfArDwCGZx8eTN
         7vW6bpSgaToRE24jS9taWcyCNCul/ZsXvYoLItJoxVYYAB3x4Hpz+mW2CU01MWgYO3
         GHxbUxD4xFgE0I+gBRysXKcg6NpPV4M9/+LbMge0=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UXrQtiTzuDm7; Tue, 22 Sep 2020 21:15:29 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id BE8CC4E200E;
        Tue, 22 Sep 2020 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600809329; bh=VUGrSclU1XhJlSqt4y7Ch9vosKRFqpaAskysoliTNms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=reDGxY+7L5s/bi6qVWNI5DAG6aKZexmsmteICFuggDm8vzZOfQNqndWqSEA9BNxHc
         jFb9+s2BjESG4YHdkGsCdqtluMgd1HvQYSt5sosFpN3Mtpana+X4w7e5Xx+lVHvUHz
         RDjoIuDDUZ+ivfgo/izelK5TN47sXjLGZ/3eCqDI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Sep 2020 14:15:29 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     kernel@puri.sm, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: Re: [PATCH 0/4] RFC: USB C extcon patchset for the tps6598x
In-Reply-To: <20200921143757.GG1630537@kuha.fi.intel.com>
References: <20200914164639.1487650-1-angus@akkea.ca>
 <20200921143757.GG1630537@kuha.fi.intel.com>
Message-ID: <a2d1df939e59e270bc8924b43b4dcf8a@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 2020-09-21 07:37, Heikki Krogerus wrote:
> On Mon, Sep 14, 2020 at 09:46:35AM -0700, Angus Ainslie wrote:
>> We have a complex set of hardware components to manage our USB C data 
>> and
>> power. For these to work together we decided to use extcon to 
>> communicate
>> the system changes as various cables and devices are plugged in/out. 
>> We did
>> look at usb_roleswitch and the charging framework but thought it would 
>> be
>> preferable to keep all of the information together in one system.
>> 
>> The components we have in the system are:
>> 
>> 1) TPS65982 type USB type C controller
>> 2) dwc3 IP in the imx8mq
>> 3) BQ25895 battery charger
>> 
>> I'll break this into 2 parts the data role and the power role.
>> 
>> For the data role the TPS65982 senses connect and disconnect as well 
>> as data
>> source/sink. It is also controlling the USB 3 data lanes. The display 
>> port and
>> USB 3 muxing is handled by a different chip and we'll submit patches 
>> for that
>> later on. The dwc3 controls the USB 2 data lanes.
>> 
>> On the power side there are even more moving pieces. The TPS65982 
>> negotiates
>> the power delivery contract, the dwc3 senses the BC1.2 charging 
>> current and the
>> BQ25895 sets whether we are sinking or sourcing current and what the 
>> current
>> limit is of the sink and source.
>> 
>> For both the data and power roles no single chip has all of the 
>> required
>> information. Is using extcon the correct way of doing this and if not 
>> what
>> are the alternatives ?
> 
> Do not use extcon with the Type-C drivers unless you have some really
> good reason for not using the dedicated frameworks for each thing. The
> reason why we even have some of the dedicated frameworks in the first
> place, for example the USB role switch class, is because extcon simply
> could not be made to work on every type of hardware architecture.
> 
> So you will need to register a power supply in tps6598x.c just like
> the other USB Type-C drivers like tcpm.c and ucsi.c if the TPS65982
> does not communicated directly with the BQ25895. That can be one
> of "supplied_from" (and also "supplied_to" if needed for sourcing) for
> the bq25890_changer. You probable only need to implement the
> external_power_changed() hook for it if it's missing in order to make
> it work. You can also register a power supply in dwc3 and use it as a
> second supply for bq25890 if you still really need to handle BC1.2.
> 
> The data role should already be handled for you. dwc3 already
> registers an USB role switch, and tps6598x.c already configures one.
> For data role you should not need any additional code.
> 
> Please note that there is also framework for the alt mode muxes.
> 

Thanks for looking this over. I'll investigate the power supply 
framework.

Angus

> 
>> The extcon extensions allow us to communicate the the power roles 
>> amongst
>> the various chips.
>> 
>> This patch series has been tested with the 5.9-rc4 kernel on the 
>> Purism
>> Librem5 HW. Assuming this is the correct way to use extcon there will 
>> be
>> follow on patches to the BQ25895 and dwc3 drivers.
>> 
>> Strictly speaking only the first 3 patches are needed for extcon 
>> support, the
>> forth patch decodes the power delivery contracts which makes use of 
>> the extcon
>> system.
>> 
>> 
>> Angus Ainslie (4):
>>   extcon: Add USB VBUS properties
>>   usb: typec: tps6589x: register as an extcon provider
>>   usb: typec: tps6598x: Add the extcon USB chargers
>>   usb: typec: tps6598x: Add the power delivery irq
>> 
>>  drivers/usb/typec/tps6598x.c | 488 
>> ++++++++++++++++++++++++++++++++++-
>>  include/linux/extcon.h       |  17 +-
>>  2 files changed, 503 insertions(+), 2 deletions(-)
>> 
>> --
>> 2.25.1
> 
> thanks,
