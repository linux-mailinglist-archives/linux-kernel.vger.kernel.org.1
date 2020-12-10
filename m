Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC002D6309
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392473AbgLJRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:08:33 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58503 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403884AbgLJRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:08:09 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 46927FF80D;
        Thu, 10 Dec 2020 17:07:24 +0000 (UTC)
Date:   Thu, 10 Dec 2020 18:07:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mmc: atmel-mci: =?utf-8?Q?Redu?=
 =?utf-8?Q?ce_scope_for_the_variable_=E2=80=9Cslot?= =?utf-8?B?4oCd?= in
 atmci_request_end()
Message-ID: <20201210170723.GD1578121@piout.net>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
 <20201210151035.GC1578121@piout.net>
 <ec71d7b8-a36b-04f5-77a8-22874ac241e1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec71d7b8-a36b-04f5-77a8-22874ac241e1@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2020 17:35:31+0100, Markus Elfring wrote:
> >> A local variable was used only within an if branch.
> >> Thus move the definition for the variable “slot” into the corresponding
> >> code block.
> >>
> >
> > What is the improvement here?
> 
> A possible refactoring.
> https://refactoring.com/catalog/reduceScopeOfVariable.html
> 

I quote:
"Since declarations of variables in many cases costs computational
cycles, you may end up wasting time for nothing."

This is false, it doesn't.

I also quote:
"When I'm writing new code I find I don't scope my temps any less than
method scope. This is because I keep my methods short, so reducing scope
any further doesn't add much value. The value of this refactoring is in
breaking up a large method."

Is that function large? It is not.


> 
> > This makes the code harder to read.
> 
> Can the extra null pointer initialisation trigger a source code analysis warning
> like “Addresses-Coverity: ("Unused value")” for this function implementation?
> 

Did you check, does it? It doesn't.

Are you wasting maintainer and reviewer's time? Yes you are.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
