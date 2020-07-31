Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686F223494C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 18:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbgGaQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 12:42:06 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33088 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgGaQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:42:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id BC1488030808;
        Fri, 31 Jul 2020 16:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XQN6kdJO9y5U; Fri, 31 Jul 2020 19:41:58 +0300 (MSK)
Date:   Fri, 31 Jul 2020 19:41:57 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        "Nguyen, Dinh" <dinh.nguyen@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: clocksource: dw_apb_timer: commit 6d2e16a3181b broke Arria10
 platform
Message-ID: <20200731164157.4xuh3kwqs7sfuvmn@mobilestation>
References: <SA0PR11MB4590258490EB0DD191778F04E4710@SA0PR11MB4590.namprd11.prod.outlook.com>
 <20200731064858.ts22p4i5dqcdqpaj@mobilestation>
 <5304f0ca-e098-a9f0-9f72-1485a286d93a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5304f0ca-e098-a9f0-9f72-1485a286d93a@kernel.org>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:56:37AM -0500, Dinh Nguyen wrote:
> Hi Serge,
> 
> On 7/31/20 1:48 AM, Serge Semin wrote:
> > Hello Dinh,
> > It must be something wrong with your timer2 and timer3 declared in the Arria10
> > dts because the patch didn't change anything for the first two timers (timer0 and
> > timer1). It just permits to register all DW APB Timers found in dts.
> > 
> > If those timers are broken, then you should have disabled them in the dts in the
> > first place. If they are normal, then you need to investigate further why do
> > they cause the kernel panic.
> > 
> 

> Indeed, the dts reg entry for timer3 was broken. Thanks alot for
> exposing the issue. Apologies for the noise.

No worries. Glad I could help.

-Sergey

> 
> Dinh
