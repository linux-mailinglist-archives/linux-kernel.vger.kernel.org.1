Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D51B88E6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 21:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgDYT0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgDYT0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:26:10 -0400
X-Greylist: delayed 91603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Apr 2020 12:26:10 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18508C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:26:10 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 32FD93000224F;
        Sat, 25 Apr 2020 21:26:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0363A70E960; Sat, 25 Apr 2020 21:26:07 +0200 (CEST)
Date:   Sat, 25 Apr 2020 21:26:07 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        vilhelm.gray@gmail.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, yamada.masahiro@socionext.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] gpio: thermal: Utilize for_each_set_clump macro
Message-ID: <20200425192607.qa2jr7ef2g726txr@wunner.de>
References: <cover.1587840667.git.syednwaris@gmail.com>
 <66296904e2ffce670c14576dfc7ea56417c670ab.1587840668.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66296904e2ffce670c14576dfc7ea56417c670ab.1587840668.git.syednwaris@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 12:35:02AM +0530, Syed Nayyar Waris wrote:
> This patch replaces all the existing for_each_set_clump8 and related
> function calls in the drivers (gpio and thermal) with the equivalent
> new generic for_each_set_clump macro.

Why are patches [3/6] and [4/6] included in v2 even though William
said they should be ignored?

Again, replacing for_each_set_clump8() with for_each_set_clump()
does not provide any benefit but may impact performance and makes
the code more difficult to follow.  So once more, please do not
change drivers which are known to work fine with 8 bit clumps,
specifically gpio-max3191x.c and gpio-74x164.c.

Please in the future include a list of the changes you've made
in the cover letter, not just in each individual patch.

Thanks,

Lukas
