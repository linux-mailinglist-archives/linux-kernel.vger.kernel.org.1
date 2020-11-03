Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765CC2A59BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgKCWJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:09:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52517 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbgKCUiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:38:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id c18so545080wme.2;
        Tue, 03 Nov 2020 12:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8q+3f361Qn+Zk0StgkDu+b9A9+awh+DJqyxzKTC3JY=;
        b=pn6PYw3UFrn0GlCQ5kqIh0OhUTUzUWB69yTcQjKn6r88HDnJ0EYkAtyMDtMcWgeGXO
         b99Dyupf1mXzDkqSoinS+iDBPwVkR7fS2biLJDLGKv0ldbz9dsFn3kOUk6oAm34x1kp7
         KIUufGk+cj8DKKO0QnbD4OAZhPiYPxiAXqsoYrC4FvXJ6Cv7nix54Ldu+UEeAC5c5gGf
         UfiBHet1eHNV+YUyAMQNiTLOenXOEgDb+7l1OqGSHMd29y5SFAZIn6wYjJxixkCWbIiJ
         BIM1bYXxXnwqIACbpI4gTo0pxpEFhyQY3YKenFP3KsPdksHQ2ImHxfjeaXBeK04997v+
         J38A==
X-Gm-Message-State: AOAM532J80SNyUudPmrENlAarMQaYj6I4BpabD9LxOAVkdWJiiKd1u12
        F5K7P78j9ECzviDMK4A07cr9K4i1KW0=
X-Google-Smtp-Source: ABdhPJyMEX5UOKo7cQ48A++FW9cv9b6mSl8seA9YOqX4V2JJkFsbBV7UDuOSri1wP6FCg4sRdxO0vg==
X-Received: by 2002:a1c:2d8f:: with SMTP id t137mr993227wmt.26.1604435889599;
        Tue, 03 Nov 2020 12:38:09 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v19sm3918675wmj.31.2020.11.03.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 12:38:08 -0800 (PST)
Date:   Tue, 3 Nov 2020 21:38:07 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ben Dooks <ben@simtec.co.uk>, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 14/25] soc: samsung: s3c-pm-check: Fix incorrectly named
 variable 'val'
Message-ID: <20201103203807.GA10800@kozik-lap>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-15-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103152838.1290217-15-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 03:28:27PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/soc/samsung/s3c-pm-check.c:162: warning: Function parameter or member 'val' not described in 's3c_pm_runcheck'
>  drivers/soc/samsung/s3c-pm-check.c:162: warning: Excess function parameter 'vak' description in 's3c_pm_runcheck'
> 
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Ben Dooks <ben@simtec.co.uk>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/samsung/s3c-pm-check.c | 2 +-

Thanks, applied.

Best regards,
Krzysztof

