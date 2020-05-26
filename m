Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4F1BAA76
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgD0QxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgD0Qw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:52:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12773C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:52:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so385487wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L+f5rXb1fm0ddPawdaHU5SqIUExIWo7ZaWY7+7ST/oQ=;
        b=qX0Zz/fnIDcCTmTrZNOvEAVu0G15kUG2va77BGRxQ+BmnBFWZsRrnaLHz5AJeDtNzy
         im1UlPKai40zbHFsTmlFjs0ZlJ8dSJxK5mwzZ+nAIEwEmIgCwcYm7RTGYxfXNXUnv7iT
         GvITdFyEQESb0fEeHG9nVNlC93iR5CJnTVdL0pJBSMI/cuHkO/7l0VAJaTkmAeFHzYYM
         zph00Gm2PW/XDw3Tg+sdx8+1m/6xFtHAP1MWzfbVvhm2Xbiz/TC41CE+rwGou+JPnFT8
         pd5dUPNqNOceRTLdcITOTJqqCb8zhCttUIrobwkSJqKbvweOrdCnityaPhTQz1J5bPDo
         cz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+f5rXb1fm0ddPawdaHU5SqIUExIWo7ZaWY7+7ST/oQ=;
        b=HPHDXUEpvhi5DG14aQ4RIMoGpy6lukAQUkIQb8NVkwRomG+fxvK4xTKmsRvorarJfB
         MDku/to/cUxyZd3tuLiFz+c4rbSs5w/BBPeylfZpnZk/dxB3OOCwFQnWCKNIB573sN10
         /USw7hK/+D0No4DIO+FedSd2Pse/FQ1duEM0qTmorlh4eLAxNBLuM2PI2nIyzRyWkfZz
         qo9ltP63Egaq8SnaM4UakHJr6Xr7EZQpbb1rcYRd2zekSNX8MW0yQHriEiC1JByWvjOW
         a36+LvDhGq1p2BiwdkkbSjPwUISiUWiYcMbuZs/onQ/5REa38HglmufhwIr41nB6cRxX
         9yZQ==
X-Gm-Message-State: AGi0Pubmb/AvfvPEuSys3F2bTw7hBg14NdFgO7TbbVmWT52n37DlnBzI
        5pjbpIvvCQBD564KmnWTtZlLvg==
X-Google-Smtp-Source: APiQypIg33MdzG1fsD4Vtx7fCSqJxX2k4oqiO4ZdOMqbRC/BCATKrNwRWvi691/BgqaV0F5UCCKSag==
X-Received: by 2002:a7b:c927:: with SMTP id h7mr417005wml.122.1588006377727;
        Mon, 27 Apr 2020 09:52:57 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v16sm16085225wml.30.2020.04.27.09.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:52:57 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:52:55 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] arm64: Add call_break_hook() to early_brk64() for
 early kgdb
Message-ID: <20200427165255.bjwkjobfzinzzlxb@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:43PM -0700, Douglas Anderson wrote:
> In order to make early kgdb work properly we need early_brk64() to be
> able to call into it.  This is as easy as adding a call into
> call_break_hook() just like we do later in the normal brk_handler().
> 
> Once we do this we can let kgdb know that it can break into the
> debugger a little earlier (specifically when parsing early_param's).
> 
> NOTE: without this patch it turns out that arm64 can't do breakpoints
> even at dbg_late_init(), so if we decide something about this patch is
> wrong we might need to move dbg_late_init() a little later.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

I haven't done any testing at this point (I'd hope to enable tests
for this in the test suite), however FWIW and just so you know I didn't
forget about this patch:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
