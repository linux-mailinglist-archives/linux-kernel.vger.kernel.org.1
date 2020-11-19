Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9012B9AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgKSSb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgKSSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:31:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA029C0613CF;
        Thu, 19 Nov 2020 10:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3Fwbov0n/MTQM8HXNLsQRtheMQrRru7ITImZeahaocM=; b=gm30n5gi+X6YNW+bkT1R9GCzef
        jKNYBLUUTEIfDIs0dElmSSo98C8sE50LbXtmsDWGVOdXuW4tzPOnaG7rH7Av2xhEinvwiNCw52RFp
        YAHuxpWP8oE5oDuKIT2YDbMG4jbnLH7EEFJevy38L2EAVkr7gnc57+9v9eXdTmb2wDGq7UklLVlN5
        qFFfuAxxBnJlNrzbWdjxyc/4Dmk/9NDQNPXK9Eeqt78PCRvEqKOJOW/PMfMcJVnrv7RvLWSKtgJdi
        oM7uWQRr3PrLGzgxPiZ2rJDEfHtmHCOerZ5xYKWBWoWA40O8xaBZSp9xVVNEaFwhrkhwcbFr8VAsV
        E1tSqiJg==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfoie-0008WP-KL; Thu, 19 Nov 2020 18:31:44 +0000
Subject: Re: [PATCH] docs: add a reset controller chapter to the driver API
 docs
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lee Jones <lee.jones@linaro.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        kernel@pengutronix.de
References: <20201117103306.17010-1-p.zabel@pengutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <48b0c216-69de-5c3b-1d2d-9cb23e0bc8bf@infradead.org>
Date:   Thu, 19 Nov 2020 10:31:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117103306.17010-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/17/20 2:33 AM, Philipp Zabel wrote:
> Add initial reset controller API documentation. This is mostly intended
> to describe the concepts to users of the consumer API, and to tie the
> kerneldoc comments we already have into the driver API documentation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since the RFC [1]:
> - Replaced all :c:func:`function` with function() (Jonathan Corbet)
> - Typo fixes and wording improvements (Randy Dunlap)
> - Mention new reset_control_rearm() API as a counterpart to
>   reset_control_reset() for shared resets in the Triggering section
> - Grammar fix in the Querying section
> - Add reset.rst to MAINTAINERS
> 
> [1] https://lore.kernel.org/lkml/20191022164547.22632-1-p.zabel@pengutronix.de/
> ---
>  Documentation/driver-api/index.rst |   1 +
>  Documentation/driver-api/reset.rst | 219 +++++++++++++++++++++++++++++
>  MAINTAINERS                        |   1 +
>  3 files changed, 221 insertions(+)
>  create mode 100644 Documentation/driver-api/reset.rst


> diff --git a/Documentation/driver-api/reset.rst b/Documentation/driver-api/reset.rst
> new file mode 100644
> index 000000000000..00a6ad79dd6c
> --- /dev/null
> +++ b/Documentation/driver-api/reset.rst
> @@ -0,0 +1,219 @@


> +Querying
> +--------
> +
> +Only some reset controllers support querying the current status of a reset
> +line, via reset_control_status().
> +This function returns a positive non-zero value if the given reset line is
> +asserted.

Maybe note that reset_control_status() does not accept a reset control array
as its input parameter.

> +
> +Reset control arrays
> +--------------------
> +
> +Some drivers need to assert a bunch of reset lines in no particular order.
> +devm_reset_control_array_get() returns an opaque reset control handle that can
> +be used to assert, deassert, or trigger all specified reset controls at once.
> +The reset control API does not guarantee the order in which the individual
> +controls therein are handled.


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy

