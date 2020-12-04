Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D172CF7AE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgLDXrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLDXrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:47:18 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7AC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 15:46:38 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o4so4515907pgj.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 15:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufpeo+Ar8Za9xIbYyf7Qe6TbN0AkwT1iWm/UoECGrZA=;
        b=TYkK6NyVNCykb9rbz+YQzRPEUzg8zjjeFPcfjP5cX+fa3sHpSjzMGfE0/LZwYAZKdi
         4cGUOX1Qj8JSIvS6qMYB+zJyQvHJBMm1MVAJMIEVnCwshsEBIJmolW5jU8MU8lAIDVVJ
         cJqwHJ0Lev3dpRLpAu4MyGckMWm4RHold/2vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufpeo+Ar8Za9xIbYyf7Qe6TbN0AkwT1iWm/UoECGrZA=;
        b=EQvXtdYMkXMpYYdI+XC6QR2HLdu00JdSe7kBz/Wr86G4O9WiYcSVs6vyQB6utsCazc
         j/OCA5RZwesRXJ3BKvvzuco476w7Z/hZQrwzFerPDEseDb60Ht86DwnZFonxa/OLnac/
         Pxk83RI0OaMnLZT4QG7BNtYAiltxYR1ptsBYC7VoZRa4Mc2x1Dd2oFclqhkdfTetY/xp
         sSOMnGJgabF9ln2A0w15C/MywvdHdJbv1jR6OgPXfWKqsH5jEYIFDKFhcaliSUBNjkgi
         vgT0XCdo5eqgsckvWLD23B4BnnaP5/9neoycjrvakbs2E6e6uZL4WgkfrMNZVIohPVLq
         c+WQ==
X-Gm-Message-State: AOAM531TJG2DIyguUfvvRM8lDF1/ofZLoi5YgAh+PZ7wlrs5IsOku06i
        hjm621DckNbjuE1Nj9mQheQSZA==
X-Google-Smtp-Source: ABdhPJyrmx54Y8Gw9t8+NsxSXrWAxpTu7YxMFRas1YixbGc6qfYGD//LUwtxevFl959Sjyk+dGJ7sg==
X-Received: by 2002:a05:6a00:134d:b029:18b:2cde:d747 with SMTP id k13-20020a056a00134db029018b2cded747mr6141772pfu.60.1607125597090;
        Fri, 04 Dec 2020 15:46:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s5sm3326278pju.9.2020.12.04.15.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 15:46:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: remove code for GCC versions older than 4.9
Date:   Fri,  4 Dec 2020 15:46:27 -0800
Message-Id: <160712557571.2401125.13652516939205338481.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202134929.99883-1-masahiroy@kernel.org>
References: <20201202134929.99883-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 22:49:29 +0900, Masahiro Yamada wrote:
> Documentation/process/changes.rst says the minimal GCC version is 4.9.
> Hence, BUILDING_GCC_VERSION is greater than or equal to 4009.

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: remove code for GCC versions older than 4.9
      https://git.kernel.org/kees/c/af2d22254e8e

-- 
Kees Cook

