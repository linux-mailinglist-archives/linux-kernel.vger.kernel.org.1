Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4E2825CA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgJCSKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgJCSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 14:10:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3803FC0613E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 11:10:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q123so3756667pfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKaRvvIuGMV9Y9SbY0J9Fqf4v5aSqCYAHGluZJyVI8Y=;
        b=m8zTfgZ5nk9zsbwak/95hsjBMrNTButQ1J5Cb8nADIOZ2+S/Qja97ZlIRUThOFMEpn
         80b4Y65Lz9DvoRex/MutNcLqtVYUQ86W0HSClKEa1/O4qcXg7Pn1OLAuliH48TzWtpOs
         o3nQ7zFB+G0PhCmXvKvL7C3MysBAURfGO9uxOXnnBObYjp4nvRsvLmSHdakiMnc0ltcD
         5DOA+Aq3rHA/oFrxHjJfY6+F+Yo0ryRJznFx0SngphDI6k9enN/ldQf/VqV/di0HGmZ1
         PpnGaqY0xy+ENWG/uQBFFNyXPCualnpUoFlnef/EByBtxmTi60RiT1ufCfnj0WC3leI9
         XTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKaRvvIuGMV9Y9SbY0J9Fqf4v5aSqCYAHGluZJyVI8Y=;
        b=epRgKuj/SvTebju8MfTZwuSB0S4UPZhxTNvKAXMNJuQQ9VZRveWi2RxyHXn1n0RTOe
         i18TLVD6VAqW8U6IuggpPK3oF5i7ZBOuZfRUvGHusuBiM5NcQ0N12sGfow8h53Zgq/a4
         WW8emgm7hA/2JoRAWPflUsBKbUWqrCgy2oKTb8SKitA8OkQZv2VeDgo7fu+l8+sH/JE3
         6YsVdpkJtFKtONxsFMvJy6PzQdK8r0LcGE7O7+mDlHl7b+7+CfI11qlfMJTp4FlIypBB
         +CULXql/mCB5ze2ugtUq9JzdZWFqSV2JTiMInfY3P3bEE6Wdj9LaG6QQqpxGv1SZYbMf
         xCPw==
X-Gm-Message-State: AOAM532pHG6cW/lC7pJmqKsvL5OaskASjbH4tQrhqJt8vLOHYSAgy+aK
        C4U51Lfmn/0ROP+JHF4DGmARPdC+ke5C6g==
X-Google-Smtp-Source: ABdhPJxxRGSwyvauZGdczsNIUBw0WVAFLO9XyQLYPB9rMnifnyGsOSSL0g0Vez7LEq2jerA2D4AWWQ==
X-Received: by 2002:a62:54c4:0:b029:142:2501:34d3 with SMTP id i187-20020a6254c40000b0290142250134d3mr8644081pfb.44.1601748606618;
        Sat, 03 Oct 2020 11:10:06 -0700 (PDT)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a5sm5683044pgk.13.2020.10.03.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 11:10:06 -0700 (PDT)
Date:   Sat, 3 Oct 2020 11:09:58 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH net-next] drivers/net/wan/hdlc_fr: Reduce indentation in
 pvc_xmit
Message-ID: <20201003110958.5b748feb@hermes.local>
In-Reply-To: <20201003173528.41404-1-xie.he.0141@gmail.com>
References: <20201003173528.41404-1-xie.he.0141@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Oct 2020 10:35:28 -0700
Xie He <xie.he.0141@gmail.com> wrote:

> +	if (dev->type == ARPHRD_ETHER) {
> +		int pad = ETH_ZLEN - skb->len;
> +
> +		if (pad > 0) { /* Pad the frame with zeros */
> +			int len = skb->len;
> +
> +			if (skb_tailroom(skb) < pad)
> +				if (pskb_expand_head(skb, 0, pad, GFP_ATOMIC))
> +					goto drop;
> +			skb_put(skb, pad);
> +			memset(skb->data + len, 0, pad);
>  		}
>  	}

This code snippet is basically an version of skb_pad().
Probably it is very old and pre-dates that.
Could the code use skb_pad?
