Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA801CE2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgEKSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 14:34:03 -0400
Received: from node.akkea.ca ([192.155.83.177]:44280 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbgEKSeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:34:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B56664E2006;
        Mon, 11 May 2020 18:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1589222042; bh=Da5qJJ8kOejzlzfFl55mNbToDs7NIQyVvZRPEpDqiF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=hxsG5anG1wA42sngp2H698FK6UEzs3lX5Vw+hgOEhQlPvGzbysPJ7x55dJCqCiuTx
         ImT+BESYeU0KPFXnEeqdPEGczcJFOFK91Wph/WbOJwPytkR9hAsWpzVVT1QoyXV/pm
         fT9ZCsgEB0JCUnf3bfq/J5gtDI8T8E7THNkYmbEA=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7UqCcZzt97cR; Mon, 11 May 2020 18:34:02 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 393E04E2003;
        Mon, 11 May 2020 18:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1589222042; bh=Da5qJJ8kOejzlzfFl55mNbToDs7NIQyVvZRPEpDqiF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=hxsG5anG1wA42sngp2H698FK6UEzs3lX5Vw+hgOEhQlPvGzbysPJ7x55dJCqCiuTx
         ImT+BESYeU0KPFXnEeqdPEGczcJFOFK91Wph/WbOJwPytkR9hAsWpzVVT1QoyXV/pm
         fT9ZCsgEB0JCUnf3bfq/J5gtDI8T8E7THNkYmbEA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 May 2020 11:34:02 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: ti,tps6598x: add dt binding doc
In-Reply-To: <20200511152649.GA23481@bogus>
References: <20200506191718.2144752-1-angus@akkea.ca>
 <20200506191718.2144752-3-angus@akkea.ca> <20200511152649.GA23481@bogus>
Message-ID: <ebad030b623cd8f4e2e400e78d679be4@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2020-05-11 08:26, Rob Herring wrote:
> On Wed,  6 May 2020 12:17:18 -0700, Angus Ainslie wrote:
>> Document the tps6598x driver
>> 
>> Signed-off-by: Angus Ainslie <angus@akkea.ca>
>> ---
>>  .../devicetree/bindings/usb/ti,tps6598x.yaml  | 75 
>> +++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>> 
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml:
> maintainers:0: None is not of type 'string'
> Documentation/devicetree/bindings/Makefile:12: recipe for target
> 'Documentation/devicetree/bindings/usb/ti,tps6598x.example.dts' failed
> make[1]: ***
> [Documentation/devicetree/bindings/usb/ti,tps6598x.example.dts] Error
> 1
> make[1]: *** Waiting for unfinished jobs....
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml:
> ignoring, error in schema: maintainers: 0
> warning: no schema found in file:
> ./Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml:
> ignoring, error in schema: maintainers: 0
> warning: no schema found in file:
> ./Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> Makefile:1300: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1284704
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install
> git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

I think the consesus was to use this one instead.

https://lore.kernel.org/lkml/20200507122352.1773661-2-bryan.odonoghue@linaro.org/

Thanks
Angus

