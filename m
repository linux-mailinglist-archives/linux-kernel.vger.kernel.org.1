Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED71DA624
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 02:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgETAIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 20:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgETAHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:07:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l73so1692128pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4Zua8syvVDyjlKtRUfz1/JaYZeWqEjXOGIn23EyWyY=;
        b=K+j+o19Q2tjCH8aojaNFPWFNI5EAyV3RM0XCJbordzLCrPzzRJzsvDX6PBJYj6/mXs
         y9/kW8FQem+xVoDvQ4JOnEg+Exqf5VUe6UU8eb4qdNibziBOVvkn/0A3SgEOvIZqNTeg
         LbsfdqYe3c6woAkL9qYV11X4NkGYe2+StiJB7exTsj/X2H9OKtpocEz11GQL7skYh8hj
         rIKgmaTIgrO1ntQxvY5xdDhlyNhIrXYOzIlTF+tiQxpSuHNW/fJoRrmhiyZzT9tSbyj9
         tPlAitPiGpgSxszcZBgqCbeSr/wCrYfBEJUzFDMdMCz8yTYFomT3tOySyHoR+iLVsQvC
         cZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4Zua8syvVDyjlKtRUfz1/JaYZeWqEjXOGIn23EyWyY=;
        b=golRMww4lBvsQG6V+tHVdgCYMnBVJAn3SofrO6i4n4ROvZuiqTJ//dMp4Ic/E8bIvE
         PFbn7CaxI6nRlsULYGmj0HFpsC5dVDiPZ8wp/KpAMKf0KvkUlqn6XgCm9AVNFXmI4ySF
         TxyikPnpmIjWu9/NiYiKTv80zVDdX38idh+iRq9UOHA4CvEqITOHb8HeLdoWFSLQxgpw
         IZliqT7z9zI+8pRkm0FYZXxm0v44iN2+ODg8jIY7kFhKlNeCiaPIfNt2ki2yqYKoxeUB
         dr2fGuM1awDJVIGvhksZZ0byMNdhIvrJPjgqCEPrWTiREbul0lGSggzr5SDgexZGj5t2
         6otA==
X-Gm-Message-State: AOAM532r+C4Dxn3PDxy/81lLJu6mw6uLLLMzWms3E/mA/9EoHRecUONw
        Ne3e/2ELjYgIIeI7vJNktqPtFmAEeGs2ag==
X-Google-Smtp-Source: ABdhPJzrZMtPAglu8Lp6rv2NhYAg8uMIsQJ02jmlsVDWUhGgpM4226LIixXFfHuO8Pd9+30COJ9tFw==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr1886573plr.160.1589933271579;
        Tue, 19 May 2020 17:07:51 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w186sm505288pff.83.2020.05.19.17.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 17:07:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/7] arm64: dts: meson: add internal audio DAC support
Date:   Tue, 19 May 2020 17:07:45 -0700
Message-Id: <158993320300.34448.14791273150623120523.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506221656.477379-1-jbrunet@baylibre.com>
References: <20200506221656.477379-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 00:16:49 +0200, Jerome Brunet wrote:
> This patchset adds support for the internal audio DAC found on the gxl,
> g12 and sm1 SoC family.
> 
> It was mainly tested on the gxl libretech-cc and g12a u200.
> 
> /!\
> This series (patches 1 in particular) depends on this reset binding [0].
> Philipp has provided an immutable with it here [1]
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: meson: gxl: add acodec support
      commit: a66d4ae3144a18476626dd8de8b8dff5f523daee
[2/7] arm64: dts: meson: p230-q200: add internal DAC support
      commit: f3c35382259f67c2ae878de2142fb58b94df0525
[3/7] arm64: dts: meson: libretech-cc: add internal DAC support
      commit: 249ce3777c25b383702e91a6547ffc676dc004a5
[4/7] arm64: dts: meson: libretech-ac: add internal DAC support
      commit: 451323f8bc9e9b701b87b4598ec1cac8eff82d15
[5/7] arm64: dts: meson: libretech-pc: add internal DAC support
      commit: 2989a2d6c7f36da2bddffdb293bdf123e735d5f7
[6/7] arm64: dts: meson: g12: add internal DAC
      commit: 457fa78771a23ecedf3bcd9ce9946a5183472ff6
[7/7] arm64: dts: meson: g12: add internal DAC glue
      commit: dbffd7f9bdb463437d3c3f7c3e1bd4379a785fe4

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
