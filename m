Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8442F777F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbhAOLTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAOLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:19:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C8C061793;
        Fri, 15 Jan 2021 03:18:41 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h205so12584105lfd.5;
        Fri, 15 Jan 2021 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8lRJYc4BKAdg1abXpS4nArMEOY798PG8SuBDu3ZJSlk=;
        b=Z5AjfT+9sIEoizTRGkvN4w7h+aIbEWUFfVlvbDDmlnjohr4b0yWluxpJGKYyhP8D/V
         I1i0WOneHrJlvabZSEV484vqeRo06wzgYuy4/74GQxjPiexyiI2Fkm1ofKktZpg7HkEF
         r4ZvbU4mI0geYG/QB4JeSCJf9N8xgug1O0oF5ndx9wZAMViLLczKz9zrs25GRrbzUDEv
         BJMyglfRGKtxkz4nP7IGeIWrG8nPeHLzf8SGJ9CXAJE6BD9YW/chFgczD1Sznmje0srx
         hhkjxqAvvBo8ZwYRisJz7S9OxGneqG3bM72c4IQ6Shyld3PwIXKv9EAlWxxvF/sX+Hcn
         DGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8lRJYc4BKAdg1abXpS4nArMEOY798PG8SuBDu3ZJSlk=;
        b=LrrYOgSvoFZZfGFNnQCC1EQB/hB+Mr7Iso+Vzx9YfpVJRYyTJBPT0AcVd9Zf2ycQkn
         MMXWM+janQbwgGN73MKpjv/Of04ZJN5R/wU6VnATR6bW4mQdJKV6LzCt5aLNQelwhu/W
         FpwFCnr7pVTL1hAlzK0bPbMpuIhRbGNbr4sLKYxSWq7dF4/mWtYy/unzBP2dfKgSv+Sd
         xKtJ4veYKsG1iTUPWhhCC6bPThztZ9vtv72ZVfaI5FSEWMy0qeAuPqi75ekfPT9qkj1O
         h6G0utJdCIX4lgGSuie1/eEFLalFB3EqVf4X7SRHcF/HDZOmXeiI1kgf66rx/o4HoBvC
         zIjg==
X-Gm-Message-State: AOAM5310ZbAGUg937/+/B6hZAW+6yXt0m4q0tsLjTE1oOjpBROFmbJYe
        nUDAgUTF3RGvv9CzG83MYrc=
X-Google-Smtp-Source: ABdhPJzgPbg0C6JprZSQzMH73kmf9AQHoEvG+h92c+jF6B1XAfqd45EqfR1dJgICUMDoG+cffcK6Cw==
X-Received: by 2002:a05:6512:3157:: with SMTP id s23mr5355726lfi.275.1610709520473;
        Fri, 15 Jan 2021 03:18:40 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id x125sm864994lff.58.2021.01.15.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 03:18:39 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 10FBIaNw004539;
        Fri, 15 Jan 2021 14:18:37 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 10FBITBj004538;
        Fri, 15 Jan 2021 14:18:29 +0300
Date:   Fri, 15 Jan 2021 14:18:29 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ernesto Corona <ernesto.corona@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Amithash Prasad <amithash@fb.com>, Rgrs <rgrs@protonmail.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Yiwei Zhang <zzyiwei@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Steven Filary <steven.a.filary@intel.com>,
        Alessandro Rubini <rubini@gnudd.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Johan Hovold <johan@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Patrick Williams <patrickw3@fb.com>,
        Federico Vaga <federico.vaga@cern.ch>,
        Oleksandr Shamray <oleksandrs@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: Re: [PATCH v29 1/6] drivers: jtag: Add JTAG core driver
Message-ID: <20210115111829.GB2971@home.paul.comp>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20200413222920.4722-2-ernesto.corona@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413222920.4722-2-ernesto.corona@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 03:29:15PM -0700, Ernesto Corona wrote:
> --- /dev/null
> +++ b/drivers/jtag/jtag.c
> +	 case JTAG_SIOCFREQ:
> +		if (!jtag->ops->freq_set)
> +			return -EOPNOTSUPP;
> +
> +		if (get_user(value, (__u32 __user *)arg))
> +			return -EFAULT;

Does this need to be a pointer to a variable even if it's just a
number?

> +	case JTAG_IOCXFER:
> +		if (copy_from_user(&xfer, (const void __user *)arg,
> +				   sizeof(struct jtag_xfer)))
> +			return -EFAULT;
> +
> +		if (xfer.length >= JTAG_MAX_XFER_DATA_LEN)
> +			return -EINVAL;
> +
> +		if (xfer.type > JTAG_SDR_XFER)
> +			return -EINVAL;
> +
> +		if (xfer.direction > JTAG_READ_WRITE_XFER)
> +			return -EINVAL;
> +
> +		if (xfer.endstate > JTAG_STATE_UPDATEIR)
> +			return -EINVAL;
> +
> +		data_size = DIV_ROUND_UP(xfer.length, BITS_PER_BYTE);
> +		xfer_data = memdup_user(u64_to_user_ptr(xfer.tdio), data_size);

So this might copy more bits than the user specified, but that's
probably OK.

> +		if (IS_ERR(xfer_data))
> +			return -EFAULT;
> +
> +		err = jtag->ops->xfer(jtag, &xfer, xfer_data);
> +		if (err) {
> +			kfree(xfer_data);
> +			return err;
> +		}
> +
> +		err = copy_to_user(u64_to_user_ptr(xfer.tdio),
> +				   (void *)xfer_data, data_size);

And this might overwrite some bits and it's not OK, at least not
without a warning in the documentation.

> --- /dev/null
> +++ b/include/uapi/linux/jtag.h
> @@ -0,0 +1,194 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// include/uapi/linux/jtag.h - JTAG class driver uapi
> +//
> +// Copyright (c) 2018 Mellanox Technologies. All rights reserved.
> +// Copyright (c) 2018 Oleksandr Shamray <oleksandrs@mellanox.com>
> +
> +#ifndef __UAPI_LINUX_JTAG_H
> +#define __UAPI_LINUX_JTAG_H
> +

Missing <linux/types.h>

Other API comments will be sent as a reply to the "Documentation:
jtag: Add ABI documentation" patch as they are not
implementation-specific.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
