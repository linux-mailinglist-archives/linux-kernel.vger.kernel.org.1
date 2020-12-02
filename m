Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500032CC9CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgLBWnv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Dec 2020 17:43:51 -0500
Received: from piie.net ([80.82.223.85]:45304 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgLBWnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:43:50 -0500
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 17:43:50 EST
Received: from mail.piie.net (_gateway [172.17.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id 541412A18F0;
        Wed,  2 Dec 2020 23:32:48 +0100 (CET)
MIME-Version: 1.0
Date:   Wed, 02 Dec 2020 22:32:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.14.0
From:   "=?utf-8?B?UGV0ZXIgS8Okc3RsZQ==?=" <peter@piie.net>
Message-ID: <d702f364c3bd1b31858ef5bd6d714867@piie.net>
Subject: Re: [PATCH 2/2] platform/x86/drivers/acerhdf: Check the interval
 value when it is set
To:     "Daniel Lezcano" <daniel.lezcano@linaro.org>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "Mark Gross" <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201202222212.2313242-2-daniel.lezcano@linaro.org>
References: <20201202222212.2313242-2-daniel.lezcano@linaro.org>
 <20201202222212.2313242-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2. Dezember 2020 23:22, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:

> Currently the code checks the interval value when the temperature is
> read which is bad for two reasons:
> 
> - checking and setting the interval in the get_temp callback is
> inaccurate and awful, that can be done when changing the value.
> 
> - Changing the thermal zone structure internals is an abuse of the
> exported structure, moreover no lock is taken here.
> 
> The goal of this patch is to solve the first item by using the 'set'
> function called when changing the interval. The check is done there
> and removed from the get_temp function. If the thermal zone was not
> initialized yet, the interval is not updated in this case as that will
> happen in the init function when registering the thermal zone device.
> 
> I don't have any hardware to test the changes.

Thanks for this patch, I'll test it in upcoming days.
