Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B0D2F1A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbhAKPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbhAKPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:49:43 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E582CC061794;
        Mon, 11 Jan 2021 07:49:02 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jx16so217758ejb.10;
        Mon, 11 Jan 2021 07:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZToKGTZKbZH1EPW/AH7elrckIZzJdraGl1TvIdytnU=;
        b=sMIb0sdK2jJ1FfLxd8L/kLrNsyPdfFnMI86WFIQN8Y7knhpZQkVe08zHk5k84G31VF
         vNoXzqDoaRW1RpHZClKVEcJVcjYrlXjAyJlYJERkDguodXTSCZS/zrkEavBBzy5Tmzhy
         7KWzzoXDSksavGFFnHTmpYdGkONL663i+yC4JwnNMcrMq4i4U64s+5MA2uSAF3M32I8Y
         WaSnXWLDqVyC+rrpzcyXzvdHzEIcxGyiHfIKXuW5nmkw1TRhl8MaxpUSPX7F5v0YZUoL
         zDbY6q+jCQmdUr3isdI4Zx4fhhRMaMfUt7Jp/5y0glJ8hElREj9WmpnrbckIr/ey05Mp
         hbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZToKGTZKbZH1EPW/AH7elrckIZzJdraGl1TvIdytnU=;
        b=ilO2f5w/TZW08rENrHsmZOAvpQ2Nw8yhLjoTuCNRb/DDfXtxT4kHdM5qrhd9lhkyOH
         mi3fOdsgMaYkRa3efGszp41LO8blfxGW+XlPhic4X6H2zHH0sUNL5Xo9T1VtTPQDdqry
         KheumV8rpM8UUrsHDOqyA6SzjDS7ekwJTw4qB94QvjLa0eEKTkA4POcWf4TD9u2vVH4V
         zqUQUKruZJI/c4PMjSNyh47eNl+vwLMfn692Cx958ibWZIBiXpxxgN8XbnaT7UJ2XjT7
         yw+FkikgA90ZEhHEjqziSwARxE7DZ/TcpTPTV2KmBlwjC2sWvm91q4kOMfELVaxdY5PQ
         2Wkg==
X-Gm-Message-State: AOAM532FwEwnof4K7TfRRQYQyfLqbFuwVGIAvdQJ5dpZiajO+kMzhkjh
        AP6pr5che1HWkBJv1/4gyWx5iIglgl4=
X-Google-Smtp-Source: ABdhPJwgOeOegwqq/dRFJQG3Do0UVkLOSvXR/dllyzYHzzT3TYoDYLyUd5J5219oYny2jZ4W1RXfLA==
X-Received: by 2002:a17:906:890:: with SMTP id n16mr42947eje.463.1610380141304;
        Mon, 11 Jan 2021 07:49:01 -0800 (PST)
Received: from xws.localdomain (pd9ea3126.dip0.t-ipconnect.de. [217.234.49.38])
        by smtp.gmail.com with ESMTPSA id d22sm7182671eja.72.2021.01.11.07.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:49:00 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/2] platform/surface: aggregator_cdev: Fixes for CI analysis
Date:   Mon, 11 Jan 2021 16:48:49 +0100
Message-Id: <20210111154851.325404-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are some patches addressing two issues in the Surface Aggregator
user-space interface reported by Colin Ian King via static analysis.

Maximilian Luz (2):
  platform/surface: aggregator_cdev: Fix access of uninitialized
    variables
  platform/surface: aggregator_cdev: Add comments regarding unchecked
    allocation size

 .../surface/surface_aggregator_cdev.c         | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.30.0

