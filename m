Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201A22D1941
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgLGTQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGTQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:16:23 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9053BC0617B0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 11:15:37 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t3so9719456pgi.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R281r86foH4X6REmvNo1bWa35rW491WPz1BS3w8uDtE=;
        b=h/mR90QN7U002D2Eg3T2GQrffXHyFuVCfTsDraTJiviMXMaclWXZWB/8nEmllhxw4N
         XAwTRDv6/nfrVdP40TClyN9/+07T3iuxZ4P4F2nz0Uy6qbKO7qLVEgkK9vD03T4h9fGi
         4WSVPQyqMGY8TGMaSzFP3Us/0JzLWRFTSdomBlZrxEKXIP5/MHnopT/fRABDIunUZqg9
         NUsj+KV4EmYcX7jwb4b7rfuZn9XOrwSzdTSkvqnfCyVMEeVjG9oy06f+8UqIn0ojg3W9
         7vq58ouwpUTO05r1hY1StSUfpfJx55mTecSiP6jZNVgXw7/98pH4IxD92V7JOza05z3s
         2mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R281r86foH4X6REmvNo1bWa35rW491WPz1BS3w8uDtE=;
        b=AXlLnIHaP4Ru+DPVK2Qajg3qFO5nRJAdQwN4YVGEo5FMC2IMci2zPpthN/e8lvF2ZV
         uKgCGE6LIguy/8yE44ntex6PPmUOXODKprE9GUSkvXDEaHvinuZ0xb76BX3+AszjKGd0
         LMwoWHa+ZsXT152NdhNszxbVkve6xUAxgdYeS7Xr5+VCZSio69/P4dRZb4ahRxH6z8US
         s5oMkabP78IC8N+TvUrJf+HvYMBr1cIgLWSPWLgB4U16355CacFSSyGJaXdP9DyKK+O5
         cv8NkwKTFaw7/0w9vWF699ymQdN9FR5mwU2h6N2GB5ZaW2spYtMldu5P1Du5YkCe1kuA
         Uweg==
X-Gm-Message-State: AOAM533VyKRbjUJvlPE/cop0lDdkyhlF+62J0suqof9zTz1jwVabvHK8
        gGC9mvZCA/MC3J43cz/BVA8vbQ==
X-Google-Smtp-Source: ABdhPJxsPHdCiXs0qC3DtPPvQxXD5rQIR9X6Yp/ZstsZeVJbY3nmLjIaQmRfifjK4MJzBYv5cGyNzA==
X-Received: by 2002:a65:4c87:: with SMTP id m7mr19491064pgt.75.1607368537114;
        Mon, 07 Dec 2020 11:15:37 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w12sm15134149pfn.136.2020.12.07.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:15:36 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: minor fixups for Khadas VIM/VIM2 dts
Date:   Mon,  7 Dec 2020 11:15:32 -0800
Message-Id: <160736852894.39684.13019581328411383803.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201203061605.9603-1-christianshewitt@gmail.com>
References: <20201203061605.9603-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 06:16:05 +0000, Christian Hewitt wrote:
> Reorder the VIM/VIM2 includes/bindings to follow the format of other dts
> in the Amlogic tree and remove a stray empty line in the VIM2 dts.

Applied, thanks!

[1/1] arm64: dts: meson: minor fixups for Khadas VIM/VIM2 dts
      commit: c993c4e84369acf5686a6f345ebb0efb0107f73e

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
