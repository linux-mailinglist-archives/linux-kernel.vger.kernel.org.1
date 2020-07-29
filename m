Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD90231AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgG2Hzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 03:55:33 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37066 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2Hzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:55:32 -0400
Received: by mail-ej1-f67.google.com with SMTP id qc22so8540624ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cS/+Mb8l5RDeAGjkm/i6R3tSmlr29GRgCOAZqF5RqyI=;
        b=aHTXLsDQvUmvx+xSOQiIhMYPL1VBxleoBXp8CFCG8KYocuBK6UCPBntpOcsDRjtj7C
         RfwnRXc80Q3231RLEg7l59QjZxi7x9uq3tUnacW4CGzsmMnx+IjhP8gD6+rI0/KapDa6
         hwt1VTubR1Yrdo9uhtF7py+5S111ohlEhQybSKXz5xQv4Rpi6uuCQsjYM+tms3y7sAX8
         6qoxwklU2ReivQfctJxmlxyNX16/HwSHlnbtVol3Fz1PZjqA3PgWfKO782LOhEKGt5hr
         eYVrV1giqmzHLc9WXkuxrRQVb+fQqHDjGJtSYzVKyC7xDDoXufCgubVrf2jak7HtO0Rr
         As4w==
X-Gm-Message-State: AOAM530IIkTjI3cJSfSQ7tSC4VXSCx4RfCVJWM08XAE9jnQ0Q5gYtE4d
        NvWfwoUFf+CmEazZgr7QVgY=
X-Google-Smtp-Source: ABdhPJxL+KUfBSocsvHKE0GOA7TjoWaG0cvE8sMkN0jypbsUZlrcCEwYQ/lxqqL6ZW7EgJ8/andNUA==
X-Received: by 2002:a17:906:74d0:: with SMTP id z16mr13784294ejl.51.1596009330805;
        Wed, 29 Jul 2020 00:55:30 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y7sm925862ejd.73.2020.07.29.00.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 00:55:30 -0700 (PDT)
Subject: Re: [PATCH 3/3] tty: Use the preferred form for passing the size of a
 structure type
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1595543280.git.gustavoars@kernel.org>
 <b04dd8cdd67bd6ffde3fd12940aeef35fdb824a6.1595543280.git.gustavoars@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <68c3dff9-816c-fb45-3af5-015be2443159@kernel.org>
Date:   Wed, 29 Jul 2020 09:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b04dd8cdd67bd6ffde3fd12940aeef35fdb824a6.1595543280.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 07. 20, 0:34, Gustavo A. R. Silva wrote:
> Use the preferred form for passing the size of a structure type. The
> alternative form where the structure type is spelled out hurts
> readability and introduces an opportunity for a bug when the object
> type is changed but the corresponding object identifier to which the
> sizeof operator is applied is not.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Jiri Slaby <jirislaby@kernel.org>

The other 2 ones are already acked by me.

thanks,
-- 
js
