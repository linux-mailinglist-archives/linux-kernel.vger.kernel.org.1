Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3F29508A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444385AbgJUQPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390714AbgJUQPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:15:30 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0176E2087D;
        Wed, 21 Oct 2020 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603296930;
        bh=o+6Nw7JBFzp/tMxRinSwaVXytDlrUw6zFmFs5/eos3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQh6xOzUbIuPrXQc2Dan86HKfH70ANYmDDnPsTVKw/a4DpsmA2qzqvoDBLYjwmpXQ
         +uoGMkTg5EQd1YC0SI/7rmYxARAKrTuOSHf1i8ZveyCYwiwAUHtnMbq2f5A2p6KnwM
         2xY357+Mw8d0/BKx5JFFCzvPYg5Lv32ujHJjhc3M=
Received: by pali.im (Postfix)
        id 82BB7AF1; Wed, 21 Oct 2020 18:15:27 +0200 (CEST)
Date:   Wed, 21 Oct 2020 18:15:27 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andre Heider <a.heider@gmail.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?Q?G=C3=A9rald?= Kerma <gerald@gk2.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add support for LED2
Message-ID: <20201021161527.nldudahg64lnfa42@pali>
References: <20201006124455.16617-1-pali@kernel.org>
 <20201019080408.iv7vmj63cgt2i6vg@pali>
 <2b5b0648-eccb-e4b5-fba1-43f03f054a20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b5b0648-eccb-e4b5-fba1-43f03f054a20@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 October 2020 17:01:19 Andre Heider wrote:
> On 19/10/2020 10:04, Pali Rohár wrote:
> > Hello! Gregory, I would like to remind you following patch.
> > 
> > Andre, if you have a time, could you test it too?
> 
> I would, but I desoldered all LEDs a long time ago because they're way too
> bright...

No, problem, on V5 is needed just to check that led2 is not exported in sysfs.
