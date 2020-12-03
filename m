Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3392CCCFF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgLCDGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgLCDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:06:34 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477A3C061A51
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 19:05:48 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so600389lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 19:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjGqpET2Joyaoa7pzBRRAhyQfbOzaMh2Cn5V13dsplE=;
        b=I+pPbRO5c82mvmvPX68U+/RmZLa6WAUb1BetR7a1l1k0/uZe8sCTrzeNyeq1dOCIoN
         4wKCnXDzP6us8JTEPAqSkctAgAox+KlaWfH3bokxL2UzUPiKDe2JcXhumoRAPTjJazI1
         tTQlG/age4OsofVWBzdTcKpfzibcVHbov3KMGthT2vAVBWeKXz+MYC+WFiQyfjU4KHl8
         bE4D8BFDnu7w7HS6f4Znw3/X3tjJrk1oA0DnZgskez29UH42jFOAwslEfCGnYposIbWn
         wWUCESvpJStwijIfI/FI0xE9cGd36BNXMIre3tNgmFop7TGf9NvNZqw8XOPi4BaKuE61
         wkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjGqpET2Joyaoa7pzBRRAhyQfbOzaMh2Cn5V13dsplE=;
        b=kFVlDtbclXAB2mcyAR1vD9AkRpW0fjWuL/8A0g+ud6WU0wHaycE+5kvPPi5JhPUDCc
         a+KZiZ39auL6O1iei8+AI2/XuvBtwUd0lcIDvKtl1JMYJ2J8xuaRDK8XAmAWFe/5eXVP
         tv+wOpNxT7ReF5rxFjpCa5bmubETiRL4CncVL9JaOuapeXU8CUil5htnuFfIntxrp4cF
         UR8HrY8ynIGUgwqSLxIsKaqsMIcazEMA3DRlGsA4AYsYEweOhYwU4J60shcj6/tcilh+
         cctXZvbeWkPRadDAJWgwf0quTZseOy/PWfZUaTP3SMZS+jWVwxKfPmIt/ixYZ7MPH9HD
         LA6A==
X-Gm-Message-State: AOAM533/p1V/v7PL3PG/dTiznoru030nX/FX3J8IZlKneDJg24THJ8WU
        0chXeRFgE2YRXfrx4PLd8wPMQYo/WXyDfJk9OCnniQ==
X-Google-Smtp-Source: ABdhPJx9+B/2Wz+X4W05KTZTghYz5A8vZdtxVvQbfTolC37irr33alvURfDzouHDIjdGl4Eyp/AZQA13tG3tovI4E2o=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr426142lfg.167.1606964746628;
 Wed, 02 Dec 2020 19:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <20201202190824.1309398-2-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Dec 2020 11:05:35 +0800
Message-ID: <CABVgOSm=mrEwjTMy9TeGRwCnVqmEtJGiqSBiURQk7unfHYLH+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kunit: tool: stop using bare asserts in unit test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Use self.assertEqual/assertNotEqual() instead.
> Besides being more appropriate in a unit test, it'll also give a better
> error message by show the unexpected values.
>
> Also
> * Delete redundant check of exception types. self.assertRaises does this.
> * s/kall/call. There's no reason to name it this way.
>   * This is probably a misunderstanding from the docs which uses it
>   since `mock.call` is in scope as `call`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good, thanks!

Reviewed-by: David Gow <davidgow@google.com>


-- David
