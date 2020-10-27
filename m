Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053E729C904
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830109AbgJ0TdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:33:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34328 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503729AbgJ0TdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:33:23 -0400
Received: by mail-io1-f67.google.com with SMTP id z5so2845304iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4V9X8YMdnU7xkYmFuqBYNWZd969zLvd7UVJ8Cx8Qcv4=;
        b=BZlVmNW4CuHaIEuMQ7SiEE9ss1dnZgaSRDm4PGQtox9mwkuDxUOcoknCqDgPWwicvV
         D5OhWfMFfV4j1SRog6Lclf5Mvux4smkz6GveYg/X6kz/pH0uZM+9jegMZf8/Ru5C0oAM
         TGezvmGvQBed3X3FBdYJnXfvYm5X1l6BUD4QeDG32Nm2lABNhFs/xvM1vp+P7H4yxEUM
         uJiaV4DQubkL1fv0Gabjmxhniu+ojsbtqi6bzxKb8fgOAfeqCfyXxqcVXS7cG+HqftUE
         fKQV4NxN6Cjws0s0HZbbztYz68qIQZKQGkN2Z9PhHlFGRhmG2P+9GK2Ghx5uM7ateM/G
         0KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4V9X8YMdnU7xkYmFuqBYNWZd969zLvd7UVJ8Cx8Qcv4=;
        b=YoNzuTFGzO/69Y6v01bjIPZAxlc1tv51aUtfuk3ZprAExULHRYIW0KSAU0Ht+Wytw9
         MGhL8aEXUIZ3xKcXGpiI/7qpLTfBiPo6OwlWMqic+noyVDKXt9UELds8RjoFIvEJGu0z
         8xBOaspwq7PAcuJcizbTT/uCfej0pL6yBMSCsRYRaku0paZzyglEDxd4yDbMhQr/NHav
         hYKP4AaA9MtKRxX10dsqGdywYFMegDUHtMUJqaqrW15KviTyDkhdDb1JlBc83N1WjHJn
         RpazLO8EtoslK8PPJ4Cwe95oHlckHJAlU+SS/IP9hUTdxvKcQVKSqQ/cvdJpG+HEd6W5
         CPag==
X-Gm-Message-State: AOAM532GbOQf+HvsPMmM8nAkhEsU7tIF3S9fcg6Ir/A8kNQ1Bj9CygS7
        4mZZScjuOqdL0JcRri7qAH74oKsKfLhJSA==
X-Google-Smtp-Source: ABdhPJzhPC5zdj7GD82FUWpF8CA3St8rBqN7clJeCuk6yQql51JKsIyQDnf658cYkYW6IuRY3YYLLw==
X-Received: by 2002:a6b:ef15:: with SMTP id k21mr3571221ioh.37.1603827200706;
        Tue, 27 Oct 2020 12:33:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm1264561iop.14.2020.10.27.12.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:33:19 -0700 (PDT)
Subject: Re: [PATCH] mm/process_vm_access: Add missing #include
 <linux/compat.h>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201027182246.651908-1-geert+renesas@glider.be>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9bfc1775-3cd3-8b5e-23b6-8d4b78536147@kernel.dk>
Date:   Tue, 27 Oct 2020 13:33:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027182246.651908-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 12:22 PM, Geert Uytterhoeven wrote:
> With e.g. m68k/defconfig:
> 
>     mm/process_vm_access.c: In function ‘process_vm_rw’:
>     mm/process_vm_access.c:277:5: error: implicit declaration of function ‘in_compat_syscall’ [-Werror=implicit-function-declaration]
>       277 |     in_compat_syscall());
> 	  |     ^~~~~~~~~~~~~~~~~
> 
> Fix this by adding #include <linux/compat.h>.

Oversight on my part, didn't fail on my configs. Linus, can you pick
this one up?

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

