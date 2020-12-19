Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCEA2DEEB4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgLSMWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 07:22:35 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36153 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgLSMWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:22:35 -0500
Received: by mail-ed1-f51.google.com with SMTP id b2so5117335edm.3;
        Sat, 19 Dec 2020 04:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7CIqUqmOGLZ0mp6sNSfp4lkjS7I5dr+BtCqrvHyS8s=;
        b=kQA830HC+fyFYsxdhry2Ite8WNe7pnIRvXBzIqUZ5n/AaC8a6yN9x1zsJQCZ5oDLpa
         MiqNc6vN5k2PLQ+YLyDRPAOYRE0i/OB63mc4S40zXEJs7XYfr/qclILYAANf9xfpre3u
         Mwmtob2i38qqrjtPBBESl/EdIXZKfMpogwSMUeLfMNeQYwriYGfaphwyxLINqAcsIUFs
         FXYhEXa7TtSjHiA/4c5YKU1Nh890iI0ZCUHlISwW3tn4LJbkKu1LswCGNOYSuMctCyp3
         okgQ5F1jkfGQWh60e15dw1vtZzIRCKbN9cwreFB6lgZF6KymDmGKJbr6+YDnqMyefkJv
         n6ZA==
X-Gm-Message-State: AOAM533U4/2Nzus4hLxwPGguZHn2+BhNSnkreAftcQU+nj1zXLeXTzhs
        aGF7UYWpzPT3zmMl2demyfk=
X-Google-Smtp-Source: ABdhPJxVY5fj/vPjlBLHkrQ3tYbMvQ9z6WbjQwS+0zru8J9gT1HsR0IsxkE+m9OuRCSDUrGcoDj9vg==
X-Received: by 2002:aa7:c753:: with SMTP id c19mr8674474eds.358.1608380513184;
        Sat, 19 Dec 2020 04:21:53 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id ho12sm6482457ejc.45.2020.12.19.04.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:21:52 -0800 (PST)
Date:   Sat, 19 Dec 2020 13:21:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: imx8mq-librem5: Move usdhc clocks
 assignment to board DT
Message-ID: <20201219122150.GD13886@kozik-lap>
References: <20201218103131.22013-1-martin.kepplinger@puri.sm>
 <20201218103131.22013-4-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201218103131.22013-4-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:31:30AM +0100, Martin Kepplinger wrote:
> According to commit e045f044e84e ("arm64: dts: imx8mq: Move usdhc clocks
> assignment to board DT") add the clocks assignment to imx8mq-librem5.dtsi
> too.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

This should go with Fixes tag as well.

Best regards,
Krzysztof
