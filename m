Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2406D2A8742
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKETcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:32:05 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6858CC0613D4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 11:32:05 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id f21so1276502plr.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 11:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Um0ao2Ro7HvzCNbvA5nAGZxuFgMy/MdwAFFYS8m+8Ho=;
        b=rPWhiFSV8Dc8dx/FYpos+Ff7DcqQ2OBPkYGAGxJbfShz2xOFP/yLk1pi9GsE7KXWDn
         oEHNrC1wLNzaGErZQ/y4zauaJPePzueggVrgs3KRefVBSMxrktIfYNfKbbIZKUOL+8Ue
         9l0MjFLkwJaX5vMMxLIn596bnZqeP1HkPEMRG5p9xOWG9MEdRnWv6IOkuml20ClgFlox
         FXI8RKUhxH3bWtv79aaFPMa1XwAg15HPOTi6TAORdlhaELK9KaOmrX2WdppZzaHkyiI5
         IRaDOdl8zTSDFZuWmf7qdWDvxdpus0P+Rv1uMoiOlAdUV/nIhL+IqfOrjzDdslzcv6Q9
         fMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Um0ao2Ro7HvzCNbvA5nAGZxuFgMy/MdwAFFYS8m+8Ho=;
        b=qdz/oUpjQMtRjJ9z4hmeOpKKJbP7f61iEsOuPJKWBWSHLVm4vUSD0fVISWOzdiCShH
         YN3TK+VEa7108HFZ040wQThdDSfTuzKNMbGaCaK2kO00ZRO1fKmT6qcaTAM7renXYb8d
         7bo8SwSjtPAntswknoCWynzEFZEFF9f8EBoq0GLlC47M1ReH9XVs4opfJUfJ5zOiUi0L
         DEIDg0zVVqVTeD7Oo3XfO8vpM0yr1Tge7LehjWnB5pjRtlcGeZ7sr0aqKmX9rgT56Jet
         JDcrPXZ0wVSdl7/MLNnaGMnkuUNP5nLoHXG3r4kMD62+6OINtms2lUlP7fIeIsqcFF0g
         QIGA==
X-Gm-Message-State: AOAM531lX8ecI69s0Z6iSBcFKzmUPqSOWh5x+xE+mCLqijVSLOeQzm5c
        OvUb68I4YHDLte9OorqGu+5wQA==
X-Google-Smtp-Source: ABdhPJwt1K7gChJrIWvazpJKOR3yDHs3rMBH25KsCSdXPhZY4Pbnpb7U1+slz1YvHWoj4Rz8IP2Phw==
X-Received: by 2002:a17:902:9b89:b029:d2:42a6:88f with SMTP id y9-20020a1709029b89b02900d242a6088fmr3711295plp.71.1604604724943;
        Thu, 05 Nov 2020 11:32:04 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d11sm3500918pfo.198.2020.11.05.11.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:32:04 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: remove empty lines from aml-s905x-cc v2 dts
Date:   Thu,  5 Nov 2020 11:32:02 -0800
Message-Id: <160460471585.10458.9400136193954173515.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026134101.10594-1-christianshewitt@gmail.com>
References: <20201026134101.10594-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 13:41:01 +0000, Christian Hewitt wrote:
> 


Applied, thanks!

[1/1] arm64: dts: meson: remove empty lines from aml-s905x-cc v2 dts
      commit: 8e9c052a483db5f9ae098d9b686ed80e2e98a8c5

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
