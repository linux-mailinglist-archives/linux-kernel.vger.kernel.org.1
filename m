Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6820EB43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 04:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgF3CHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 22:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgF3CHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:07:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED7C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:07:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so7237165wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=CAsTIhg9GNAtVe3y8RLBs7slHNRQHigQcda0zsTXJMU=;
        b=Ye/Aut1FZk5CUmWtGzbs4WamhVJapkHBREiS6HzooXxA+QSNZLSxcWdKhFl5fVOijI
         QjAkXfOcPdD4pvd4TadqirUYPj+IiWJsQUaT38IiTmSftGrkJ8up8qtoms5aA1v/y6mi
         Vu7l0Twb7nZ5zJ2bGH3bwa1NxyXgjHXG2qWzGRydFRxtTjH2PUSCokd5S2kSRFh+pBdv
         QtIkZDxF+rY2OxdB1UonxgPi7iLGVRqWtVEQ+BBuRa3R6YSZnkulkQecr7aCU70E2GHb
         pF3jFRCs0/Jr1OycpRlVTCbokVvameruvI62xSNa+/rG2/ucuDObn6sesburtx/jGTfP
         lu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=CAsTIhg9GNAtVe3y8RLBs7slHNRQHigQcda0zsTXJMU=;
        b=IwGYf5svEpbsG24lCqJlL4kFafpFqq/kGqDMEw1BZsp/AzwyWjZvOmxGVcEeQKtYGl
         iwQkFDKsBk29U7eFcwhzxJBwBWwAcZlip7hDT2fKHvRrwIXm4BHt4l3/gsKK9WGx8rVx
         wEjgdIkMfVuh0Re/r6Y90efYBpLksTewkpABa7U9dxmEUi9QU05T9cyYwBUP6ebbFEHt
         IoXt3xpaoCs3+AtXfCXdMHU0nzAdCvyziEguh5KiR8QF0C9kiIcpAOHSkSnX6JkDR/qf
         ODSg8tWd0kxUXcp9/8/ktGR8omHbYkRqjcr+lKi4Wlgsdtlk5WQs6ZSq5R64JiTolba8
         4uog==
X-Gm-Message-State: AOAM530pFEPR9erfkLjR0gEnffXYWCvyAbo3ZILL83KJV6Y0AWBuF22A
        JMvPNEY995RXjj9QI8C6+7c6kV8j
X-Google-Smtp-Source: ABdhPJxeBHPofo2CZ9l30kz/aGmZtBFTSZb3INkPrxOhAitO7+hEgc+1GAqPToOnJHNfIXglvf2Zvg==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr18807618wrb.385.1593482832968;
        Mon, 29 Jun 2020 19:07:12 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id l132sm1815730wmf.6.2020.06.29.19.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 19:07:12 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:07:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] ring-buffer: speed up buffer resets by avoiding
 synchronize_rcu for each CPU
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
References: <20200625053403.2386972-1-npiggin@gmail.com>
        <20200629181625.4b87a63a@oasis.local.home>
In-Reply-To: <20200629181625.4b87a63a@oasis.local.home>
MIME-Version: 1.0
Message-Id: <1593482725.5cl7vnne3j.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Steven Rostedt's message of June 30, 2020 8:16 am:
> On Thu, 25 Jun 2020 15:34:03 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> Batch these up so we disable all the per-cpu buffers first, then
>> synchronize_rcu() once, then reset each of the buffers. This brings
>> the time down to about 0.5s.
>=20
> After applying this patch, running tools/testing/selftests/ftracetest
> went from 5 minutes and 35 seconds to 5 minutes 5 seconds to complete
> on my 4 core (8 with hyperthreading) machine! That's almost a 10% drop!
>=20
> Thanks, I'm definitely applying this for the next merge window.

Cool, always good when a big system optimisation helps small ones as=20
well. Thanks all.

Thanks,
Nick

