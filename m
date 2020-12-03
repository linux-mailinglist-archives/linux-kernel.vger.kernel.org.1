Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EEA2CCE65
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 06:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgLCFQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 00:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCFQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:16:33 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3243C061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 21:15:47 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id t13so802232ilp.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 21:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0T2UjYq4UBSUMGz6lYJAaVtZcmgm37SkhIDDNy2JsW4=;
        b=vu24cf5sKdq2mdtSxBorcawv5ZXvrwH7MlyE1gIoeQ9WJ2cjuZZPeYEDnrd5DKAiV5
         MOpi4o58Cru/Y4b+Vs/UpCKHWxSt/+uEnhsrclhm4G8Sw2wEjqbGyoG1T7EGSn5XZTsD
         +wPPlFbTPrByyHsWB34kI3r+ONgEfLXxDXJwuUD6n8SZ58cFUkiKBBPDNDSwsh7CqHcL
         1tS22zob33fWS/rdtG3yzILwJdOsdIn3XXMmi/fQGtQpx9rLgIAho6K4dY+jij46UMFp
         G+3m5fKJ3Ll7EMFIAF3v3yRp4frafMTHE3L6y3+Ub04ktve5qUjlMctu7ozWQnk1PCfw
         Yk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0T2UjYq4UBSUMGz6lYJAaVtZcmgm37SkhIDDNy2JsW4=;
        b=JaQmO12eIm/rG3MT0ffgwNvZRhmpVhVjZRNEtiC/J0p5eGg7KpIjd2VPEMfQWDgzeJ
         EbmnTUYqQYZ5tyeLYQ5KmP+F2PPC5IHnIRKmIXv8vgUhcg5ciEPTRRxDDZR5tIPphrO8
         +lyNE4MTdVK9sp72QlwiQlxvhN05mXP+9GkUewpBt9L1P3hy+wGPi3Nh1fvq8BR9sHO/
         c0kQ2pANnzgIc9ZaZpZwBmqbduevOvihdVgvWQqxncXb7HuH3tAoQJ8DCdbjfmcXHRo4
         SoWvp5IBecpge2ZAqLzwOmTDaunzEKbL9BtPP7yRb/TADkqgcw8Qq+4d5WOqvGmq4d7R
         TcnA==
X-Gm-Message-State: AOAM532G9suU2EjDbnkl3li3vU7W/qmfNkC/pHRniFGMWCppXpZPsPYI
        DyuFBYF1OMF6/zpwOxUZU2pFHs/VDAT+HSUml/QYBA9KHpA=
X-Google-Smtp-Source: ABdhPJxuiKVy82egd6udynKufvhTNmRoS1PPUdfYZA0eVelYJdnv0QGsRCGulblEB4IdDY366hWrg9QO8fliQGTV8to=
X-Received: by 2002:a92:297:: with SMTP id 145mr1538148ilc.133.1606972546057;
 Wed, 02 Dec 2020 21:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <CABVgOSnqhes_Lu+4BRq74get5D3ya3S6XxMLqFKamqahU5-RRA@mail.gmail.com>
In-Reply-To: <CABVgOSnqhes_Lu+4BRq74get5D3ya3S6XxMLqFKamqahU5-RRA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 2 Dec 2020 21:15:35 -0800
Message-ID: <CAGS_qxqk_ez6hU4pO9yromMfTgamTjLmhgW_yWAZzueh9y6qZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: tool: fix unit test cleanup handling
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 7:05 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Dec 3, 2020 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > * Stop leaking file objects.
> > * Use self.addCleanup() to ensure we call cleanup functions even if
> > setUp() fails.
> > * use mock.patch.stopall instead of more error-prone manual approach
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> This patch hasn't changed since v1, right?
>
> It's still:
> Reviewed-by: David Gow <davidgow@google.com>

Oops, yes. It's entirely unchanged.

The only change to the entire series was a rebase + drop the second
patch in favor of revamping the test_data_path() one.

>
> Cheers,
> -- David
