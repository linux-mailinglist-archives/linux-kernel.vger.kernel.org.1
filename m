Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6122B9CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgKSVYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKSVYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:24:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:24:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so7889136wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PXILVwLQAgWTSDj1+RkAeJoIWEi9ZT1cE198OON+pUg=;
        b=NFDtcGLgAXo8y9lQxaIfhw/2tSFrrhjNf/mkNmEdVTj64RYH6zPTgLRZY6Vil2ZHDs
         zBI3dYhF404OSDbLdhV9tZPHITZSngLH4cFF2g0puJeArOsgsMFKfU01bq1GCssLBvZY
         9mxSXs19C0WiHhVNv4a+GFzymb7Ux9OFAMIHmSH7D2lTwKL1zfQ3CoG6ax7ZuyPmpN4U
         C72MNbPFHle9+otBsQsmhPxIEXacadqMYjCZ4Kk9s8HgGNxSB9dJeTCC4hJE2D9PxQqC
         /f4wDcLZczWmExAqOseI4b4qS3mCKAO4IxBoym+kaab017+XdSBWxXy5PR+8tEEcLpEW
         zTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PXILVwLQAgWTSDj1+RkAeJoIWEi9ZT1cE198OON+pUg=;
        b=PyLoqyxytkHCl2hcU7p6N8n1BVZoB0LrorMXWksbpm/S3feE1Mhw6PNPxfCqOirE1A
         03qO6KwE31UkOT505o40ujcP91Gfh/89gHBb4ckBt4leGOiMaEtVp14yef+XJ3yMZZ4b
         3lP/G+kxoW1YMtuTvuXlAb7OfqttFm90yeAiOk1G0Ek8H9lOQ1zUQQ7wKcJrj1Pr5dWx
         6NkNRPvUl539B9sYw1p0b5Srf0AeesmGQkHpewere2bpi99YzKe5XE4+VHHBhKEKUecQ
         INvAn9BBADXWciDfFgBjK1T/SdrwaIMgRy/2CkbqO1hgKeGEXuZJzA7f140l3nZsQqQh
         UZqQ==
X-Gm-Message-State: AOAM531mO7kYr+oQHp+bNmokAJFoZXYKW7CKLcutb6+dhcnMECtgGrIJ
        Y8TBxJ7yW2zsU+zC1sv03faf70apE5jQydxU
X-Google-Smtp-Source: ABdhPJy003kb+ygTpLPA0hKLyzOTgmeRpnQ3Ub8QlUBor3BlLdlqrQNRlrtGhWCIv8WrDh/cGOojxQ==
X-Received: by 2002:adf:8028:: with SMTP id 37mr12194257wrk.111.1605821039474;
        Thu, 19 Nov 2020 13:23:59 -0800 (PST)
Received: from ?IPv6:2001:861:3a84:7260:884a:a608:6574:a6? ([2001:861:3a84:7260:884a:a608:6574:a6])
        by smtp.gmail.com with ESMTPSA id h17sm2266339wrp.54.2020.11.19.13.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 13:23:58 -0800 (PST)
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
        Randy Dunlap <rdunlap@infradead.org>, kernel@pengutronix.de
References: <20201117103306.17010-1-p.zabel@pengutronix.de>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Message-ID: <390a9e7b-3d0a-187a-f1d1-02af01ee32e4@baylibre.com>
Date:   Thu, 19 Nov 2020 22:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117103306.17010-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On 17/11/2020 11:33, Philipp Zabel wrote:

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
>    reset_control_reset() for shared resets in the Triggering section
> - Grammar fix in the Querying section
> - Add reset.rst to MAINTAINERS
>
> [1] https://lore.kernel.org/lkml/20191022164547.22632-1-p.zabel@pengutronix.de/
> ---
>   Documentation/driver-api/index.rst |   1 +
>   Documentation/driver-api/reset.rst | 219 +++++++++++++++++++++++++++++
>   MAINTAINERS                        |   1 +
>   3 files changed, 221 insertions(+)
>   create mode 100644 Documentation/driver-api/reset.rst
>
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index f357f3eb400c..08c32952fce3 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -29,6 +29,7 @@ available subsections can be seen below.
>      infiniband
>      frame-buffer
>      regulator
> +   reset
>      iio/index
>      input
>      usb/index
> diff --git a/Documentation/driver-api/reset.rst b/Documentation/driver-api/reset.rst
> new file mode 100644
> index 000000000000..00a6ad79dd6c
> --- /dev/null
> +++ b/Documentation/driver-api/reset.rst
> @@ -0,0 +1,219 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +====================
> +Reset controller API
> +====================
> +
> +Introduction
> +============
> +
> +Reset controllers are central units that control the reset signals to multiple
> +peripherals.
> +The reset controller API is split into two parts:
> +the `consumer driver interface <#consumer-driver-interface>`__ (`API reference
> +<#reset-consumer-api>`__), which allows peripheral drivers to request control
> +over their reset input signals, and the `reset controller driver interface
> +<#reset-controller-driver-interface>`__ (`API reference
> +<#reset-controller-driver-api>`__), which is used by drivers for reset
> +controller devices to register their reset controls to provide them to the
> +consumers.
> +
> +While some reset controller hardware units also implement system restart
> +functionality, restart handlers are out of scope for the reset controller API.
> +
> +Glossary
> +--------
> +
> +The reset controller API uses these terms with a specific meaning:
> +
> +Reset line
> +
> +    Physical reset line carrying a reset signal from a reset controller
> +    hardware unit to a peripheral module.
> +
> +Reset control
> +
> +    Control method that determines the state of one or multiple reset lines.
> +    Most commonly this is a single bit in reset controller register space that
> +    either allows direct control over the physical state of the reset line, or
> +    is self-clearing and can be used to trigger a predetermined pulse on the
> +    reset line.
> +    In more complicated reset controls, a single trigger action can launch a
> +    carefully timed sequence of pulses on multiple reset lines.
> +
> +Reset controller
> +
> +    A hardware module that provides a number of reset controls to control a
> +    number of reset lines.
> +
> +Reset consumer
> +
> +    Peripheral module or external IC that is put into reset by the signal on a
> +    reset line.
> +
> +Consumer driver interface
> +=========================
> +
> +This interface provides an API that is similar to the kernel clock framework.
> +Consumer drivers use get and put operations to acquire and release reset
> +controls.
> +Functions are provided to assert and deassert the controlled reset lines,
> +trigger reset pulses, or to query reset line status.
> +
> +When requesting reset controls, consumers can use symbolic names for their
> +reset inputs, which are mapped to an actual reset control on an existing reset
> +controller device by the core.
> +
> +A stub version of this API is provided when the reset controller framework is
> +not in use in order to minimize the need to use ifdefs.
> +
> +Shared and exclusive resets
> +---------------------------
> +
> +The reset controller API provides either reference counted deassertion and
> +assertion or direct, exclusive control.
> +The distinction between shared and exclusive reset controls is made at the time
> +the reset control is requested, either via devm_reset_control_get_shared() or
> +via devm_reset_control_get_exclusive().
> +This choice determines the behavior of the API calls made with the reset
> +control.
> +
> +Shared resets behave similarly to clocks in the kernel clock framework.
> +They provide reference counted deassertion, where only the first deassert,
> +which increments the deassertion reference count to one, and the last assert
> +which decrements the deassertion reference count back to zero, have a physical
> +effect on the reset line.
> +
> +Exclusive resets on the other hand guarantee direct control.
> +That is, an assert causes the reset line to be asserted immediately, and a
> +deassert causes the reset line to be deasserted immediately.
> +
> +Assertion and deassertion
> +-------------------------
> +
> +Consumer drivers use the reset_control_assert() and reset_control_deassert()
> +functions to assert and deassert reset lines.
> +For shared reset controls, calls to the two functions must be balanced.
> +
> +Note that since multiple consumers may be using a shared reset control, there
> +is no guarantee that calling reset_control_assert() on a shared reset control
> +will actually cause the reset line to be asserted.
> +Consumer drivers using shared reset controls should assume that the reset line
> +may be kept deasserted at all times.
> +The API only guarantees that the reset line can not be asserted as long as any
> +consumer has requested it to be deasserted.
> +
> +Triggering
> +----------
> +
> +Consumer drivers use reset_control_reset() to trigger a reset pulse on a
> +self-deasserting reset control.
> +In general, these resets can not be shared between multiple consumers, since
> +requesting a pulse from any consumer driver will reset all connected
> +peripherals.
> +
> +The reset controller API allows requesting self-deasserting reset controls as
> +shared, but for those only the first trigger request causes an actual pulse to
> +be issued on the reset line.
> +All further calls to this function have no effect until all consumers have
> +called reset_control_rearm().
> +For shared reset controls, calls to the two functions must be balanced.
> +This allows devices that only require an initial reset at any point before the
> +driver is probed or resumed to share a pulsed reset line.
> +
> +Querying
> +--------
> +
> +Only some reset controllers support querying the current status of a reset
> +line, via reset_control_status().
> +This function returns a positive non-zero value if the given reset line is
> +asserted.
> +
> +Optional resets
> +---------------
> +
> +Often peripherals require a reset line on some platforms but not on others.
> +For this, reset controls can be requested as optional using
> +devm_reset_control_get_optional_exclusive() or
> +devm_reset_control_get_optional_shared().
> +These functions return a NULL pointer instead of an error when the requested
> +reset control is not specified in the device tree.
> +Passing a NULL pointer to the reset_control functions causes them to return
> +quietly without an error.
> +
> +Reset control arrays
> +--------------------
> +
> +Some drivers need to assert a bunch of reset lines in no particular order.
> +devm_reset_control_array_get() returns an opaque reset control handle that can
> +be used to assert, deassert, or trigger all specified reset controls at once.
> +The reset control API does not guarantee the order in which the individual
> +controls therein are handled.
> +
> +Reset controller driver interface
> +=================================
> +
> +Drivers for reset controller modules provide the functionality necessary to
> +assert or deassert reset signals, to trigger a reset pulse on a reset line, or
> +to query its current state.
> +All functions are optional.
> +
> +Initialization
> +--------------
> +
> +Drivers fill a struct :c:type:`reset_controller_dev` and register it with
> +reset_controller_register() in their probe function.
> +The actual functionality is implemented in callback functions via a struct
> +:c:type:`reset_control_ops`.
> +
> +API reference
> +=============
> +
> +The reset controller API is documented here in two parts:
> +the `reset consumer API <#reset-consumer-api>`__ and the `reset controller
> +driver API <#reset-controller-driver-api>`__.
> +
> +Reset consumer API
> +------------------
> +
> +Reset consumers can control a reset line using an opaque reset control handle,
> +which can be obtained from devm_reset_control_get_exclusive() or
> +devm_reset_control_get_shared().
> +Given the reset control, consumers can call reset_control_assert() and
> +reset_control_deassert(), trigger a reset pulse using reset_control_reset(), or
> +query the reset line status using reset_control_status().
> +
> +.. kernel-doc:: include/linux/reset.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/reset/core.c
> +   :functions: reset_control_reset
> +               reset_control_assert
> +               reset_control_deassert
> +               reset_control_status
> +               reset_control_acquire
> +               reset_control_release
> +               reset_control_rearm
> +               reset_control_put
> +               of_reset_control_get_count
> +               of_reset_control_array_get
> +               devm_reset_control_array_get
> +               reset_control_get_count
> +
> +Reset controller driver API
> +---------------------------
> +
> +Reset controller drivers are supposed to implement the necessary functions in
> +a static constant structure :c:type:`reset_control_ops`, allocate and fill out
> +a struct :c:type:`reset_controller_dev`, and register it using
> +devm_reset_controller_register().
> +
> +.. kernel-doc:: include/linux/reset-controller.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/reset/core.c
> +   :functions: of_reset_simple_xlate
> +               reset_controller_register
> +               reset_controller_unregister
> +               devm_reset_controller_register
> +               reset_controller_add_lookup
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..678bd80a2e65 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14948,6 +14948,7 @@ M:	Philipp Zabel <p.zabel@pengutronix.de>
>   S:	Maintained
>   T:	git git://git.pengutronix.de/git/pza/linux
>   F:	Documentation/devicetree/bindings/reset/
> +F:	Documentation/driver-api/reset.rst
>   F:	drivers/reset/
>   F:	include/dt-bindings/reset/
>   F:	include/linux/reset-controller.h

Thank you for the documentation, looks good to me !

Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.fr>

Sincerely,
Amjad

