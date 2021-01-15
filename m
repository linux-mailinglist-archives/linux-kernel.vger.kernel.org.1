Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7E2F7812
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbhAOLya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAOLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:54:29 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076B2C061757;
        Fri, 15 Jan 2021 03:53:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x20so12694390lfe.12;
        Fri, 15 Jan 2021 03:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RR0DQBk0UH5GJ+gGJ37QS6mr1kwAekWxksm1RQHJmz0=;
        b=PARlUPeh/akDo4VJd6AvJ8LUiqYQGVXO0k2kjLdmBqHFDBPL27pJnYXUN714qieO9i
         ZhG3Npful4tKG0KaBk7NJWANfQi5Q+LE2dAMNdEhz1qwJrIikECmCBzWHtgc05qFm4bC
         6jFNFu6bYDWfU+KZ+duzCONg1AQ+xQ/oeQ/u92Yriz87XlyWqVP25jK3JTFj7kX3Jcrz
         x9bmwywNpcCraqYzPIr8vONHYg2zF6Snv4DAzLEQ5a11/mV+qRnrNbfujwZD+eSecj5D
         tEsVa842pUrY2R0gVhPLB35L8UdsWaoBKUGuU/clV7RLoOhIeNybD9hdn7Mq7Q1IltG5
         HSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RR0DQBk0UH5GJ+gGJ37QS6mr1kwAekWxksm1RQHJmz0=;
        b=cYIrKRjzDx5w8w2hzsE9QYV+lZ/nJ/GuGHLW3JdqN1xyrOSQzlhbo5j5LcHplcj5Uo
         TiZuGBy1QQiBhhqIJJ6I8l2tGM0DIxWRLzLihKxXj+KUfvidT57XA6sbu0QFgl6NrCsx
         Xa8VR7ng47SzYpbwFlg03uNWGlg/kq5M3cLawp1qmjZCJ/JZYwQoVpBeDpBd5a8KtgdZ
         1gPMTTxeoFDx86veUVJme21Z0ICfmWsVmxrziSG2pFapKyu/5JgrzIqhjPpu7AXHM/jT
         J1DnjiUb/WJxzjX4qHZvnuU0ZpF468xeQMcf37mPFLCwIrS3jd0HF2kCwVPEKkd6sntb
         pXfQ==
X-Gm-Message-State: AOAM530pRwaKAGOpoXcQtjhjSnVAVsf5ClJCwRFEeudQwzh1aou+vN7E
        FGS0On0KCsUGREmDH/xgVKw=
X-Google-Smtp-Source: ABdhPJzRfzHCI5/IkkHgcRaWp6XoE68seMiDAmenu2w/55FcwPh14mqryLohHBMTMkH4GoDyLbNVtQ==
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr5404078lfm.17.1610711627550;
        Fri, 15 Jan 2021 03:53:47 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id r9sm782240ljj.127.2021.01.15.03.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 03:53:46 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 10FBrhfH004599;
        Fri, 15 Jan 2021 14:53:44 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 10FBrfwY004598;
        Fri, 15 Jan 2021 14:53:41 +0300
Date:   Fri, 15 Jan 2021 14:53:41 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ernesto Corona <ernesto.corona@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Steven Filary <steven.a.filary@intel.com>,
        Amithash Prasad <amithash@fb.com>,
        Jiri Pirko <jiri@mellanox.com>, Rgrs <rgrs@protonmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Patrick Williams <patrickw3@fb.com>,
        Oleksandr Shamray <oleksandrs@mellanox.com>
Subject: Re: [PATCH v29 3/6] Add Aspeed SoC 24xx and 25xx families JTAG
 master driver
Message-ID: <20210115115341.GC2971@home.paul.comp>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20200413222920.4722-4-ernesto.corona@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413222920.4722-4-ernesto.corona@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please note that JTAG_XFER_HW_MODE seems to be broken, at least it
doesn't work in my testing with exactly the same userspace and
hardware so I wasn't properly evaluating it.

On Mon, Apr 13, 2020 at 03:29:17PM -0700, Ernesto Corona wrote:
> --- /dev/null
> +++ b/drivers/jtag/jtag-aspeed.c
...
> +/*#define USE_INTERRUPTS*/

I think if you implemented support for interrupts and DeviceTree
provides the resource, then it should be enabled. If the support is
untested or known to be buggy, it should be removed altogether and can
be introduced later when the issues are sorted out.

> +struct aspeed_jtag {
> +	void __iomem			*reg_base;
> +	void __iomem			*scu_base;

SCU is manipulated by a separate driver, it shouldn't be here.

> +/*
> + * This is the complete set TMS cycles for going from any TAP state to any
> + * other TAP state, following a "shortest path" rule.
> + */
> +static const struct tms_cycle _tms_cycle_lookup[][16] = {
> +/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
> +/* TLR  */{{0x00, 0}, {0x00, 1}, {0x02, 2}, {0x02, 3}, {0x02, 4}, {0x0a, 4},
> +/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
> +	    {0x0a, 5}, {0x2a, 6}, {0x1a, 5}, {0x06, 3}, {0x06, 4}, {0x06, 5},
> +/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
> +	    {0x16, 5}, {0x16, 6}, {0x56, 7}, {0x36, 6} },

This belongs to the generic JTAG architecture layer rather than an
individual driver.

> +static int aspeed_jtag_freq_set(struct jtag *jtag, u32 freq)
> +{
> +	struct aspeed_jtag *aspeed_jtag = jtag_priv(jtag);
> +	unsigned long apb_frq;
> +	u32 tck_val;
> +	u16 div;
> +
> +	apb_frq = clk_get_rate(aspeed_jtag->pclk);
> +	if (!apb_frq)
> +		return -ENOTSUPP;
> +
> +	div = (apb_frq - 1) / freq;
> +	tck_val = aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_TCK);
> +	aspeed_jtag_write(aspeed_jtag,
> +			  (tck_val & ~ASPEED_JTAG_TCK_DIVISOR_MASK) | div,
> +			  ASPEED_JTAG_TCK);
> +	return 0;
> +}

ASPEED datasheet says PCLK * 2 is used as the prescaler source, so
this calculation is probably incorrect. This implementation seems to
be also failing to check for the lower and upper limits and return an
error in case the request can't be fulfilled.

> +static inline void aspeed_jtag_slave(struct aspeed_jtag *aspeed_jtag)
> +{
> +	u32 scu_reg = readl(aspeed_jtag->scu_base);
> +
> +	writel(scu_reg | ASPEED_SCU_RESET_JTAG, aspeed_jtag->scu_base);
> +}

reset_control_(de)assert should be used instead of direct SCU
manipulation, here and in all the other places too.

> +static void aspeed_jtag_end_tap_state_sw(struct aspeed_jtag *aspeed_jtag,
> +					 struct jtag_end_tap_state *endstate)
> +{
> +	/* SW mode from curent tap state -> to end_state */
> +	if (endstate->reset) {
> +		int i = 0;
> +
> +		for (i = 0; i < ASPEED_JTAG_RESET_CNTR; i++)
> +			aspeed_jtag_tck_cycle(aspeed_jtag, 1, 0);
> +		aspeed_jtag->status = JTAG_STATE_TLRESET;
> +	}
> +
> +	aspeed_jtag_set_tap_state(aspeed_jtag, endstate->endstate);
> +}

endstate->tck is ignored.

> +static int aspeed_jtag_status_set(struct jtag *jtag,
> +				  struct jtag_end_tap_state *endstate)
> +{
> +	struct aspeed_jtag *aspeed_jtag = jtag_priv(jtag);
> +
> +	dev_dbg(aspeed_jtag->dev, "Set TAP state: %s\n",
> +		end_status_str[endstate->endstate]);
> +
> +	if (!(aspeed_jtag->mode & JTAG_XFER_HW_MODE)) {
> +		aspeed_jtag_end_tap_state_sw(aspeed_jtag, endstate);
> +		return 0;
> +	}
> +
> +	/* x TMS high + 1 TMS low */
> +	if (endstate->reset) {
> +		/* Disable sw mode */
> +		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_SW);
> +		mdelay(1);
> +		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_CTL_ENG_EN |
> +				  ASPEED_JTAG_CTL_ENG_OUT_EN |
> +				  ASPEED_JTAG_CTL_FORCE_TMS, ASPEED_JTAG_CTRL);
> +		mdelay(1);
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_SW_TDIO, ASPEED_JTAG_SW);
> +		aspeed_jtag->status = JTAG_STATE_TLRESET;
> +	}
> +
> +	return 0;
> +}

endstate->tck is ignored.

> +static int aspeed_jtag_xfer_push_data_last(struct aspeed_jtag *aspeed_jtag,
> +					   enum jtag_xfer_type type,
> +					   u32 shift_bits,
> +					   enum jtag_endstate endstate)
> +{
> +	int res = 0;
> +
> +	if (type == JTAG_SIR_XFER) {
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_IOUT_LEN(shift_bits) |
> +				  ASPEED_JTAG_CTL_LASPEED_INST,
> +				  ASPEED_JTAG_CTRL);
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_IOUT_LEN(shift_bits) |
> +				  ASPEED_JTAG_CTL_LASPEED_INST |
> +				  ASPEED_JTAG_CTL_INST_EN,
> +				  ASPEED_JTAG_CTRL);
> +		res = aspeed_jtag_wait_instruction_complete(aspeed_jtag);
> +	} else {
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_DOUT_LEN(shift_bits) |
> +				  ASPEED_JTAG_CTL_LASPEED_DATA,
> +				  ASPEED_JTAG_CTRL);
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_DOUT_LEN(shift_bits) |
> +				  ASPEED_JTAG_CTL_LASPEED_DATA |
> +				  ASPEED_JTAG_CTL_DATA_EN,
> +				  ASPEED_JTAG_CTRL);
> +		res = aspeed_jtag_wait_data_complete(aspeed_jtag);
> +	}
> +	return res;
> +}

endstate is ignored.

> +static int aspeed_jtag_init(struct platform_device *pdev,
> +			    struct aspeed_jtag *aspeed_jtag)
> +{
> +	struct resource *res;
> +	struct resource *scu_res;
> +#ifdef USE_INTERRUPTS
> +	int err;
> +#endif
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	aspeed_jtag->reg_base = devm_ioremap_resource(aspeed_jtag->dev, res);
> +	if (IS_ERR(aspeed_jtag->reg_base))
> +		return -ENOMEM;
> +
> +	scu_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	aspeed_jtag->scu_base = devm_ioremap_resource(aspeed_jtag->dev,
> +						      scu_res);
> +	if (IS_ERR(aspeed_jtag->scu_base))
> +		return -ENOMEM;

This always fails either because the second IORESOURCE_MEM wasn't
specified at all (as per the provided example in the dt-bindings
documentation) or because the SCU region is already claimed by the SCU
driver (if you try to specify it). Apparently this version of the
patch series wasn't run-time tested at all. The driver works if this
is removed altogether because reset_control_(de)assert calls do the
right thing.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
