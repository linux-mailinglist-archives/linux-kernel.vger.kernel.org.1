Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1627E27E77A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgI3LMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3LME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:12:04 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FFC061755;
        Wed, 30 Sep 2020 04:12:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y17so1631251lfa.8;
        Wed, 30 Sep 2020 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TiKnp6d4A9NoyrvVfBTW7z7jtwVDgy0Ld9EMWJo4glo=;
        b=aCebHOBf1xCs78MYYagMgvmhL3xW6yIcynW8fsHSI+82LiCclhKL/QmYPA895nJMzK
         y7M4LPlYi9+URvNUiLpAh8R/loaQq21Q7W7A1TktTkbym8MChVGQik+3SzBbCdnvlIpR
         bKsyD+Z+dtPfrIFgKpoCAaNY1dPk2RLknVAquYdyiUaTOBLiVZ/DyHFHhdcBifhnOIrN
         a9fdtwna9xtWq10Tts4eKzEJwVk/pZQYjx9OixflbUTWeOqZzW00q5HdkJRBQZS4v7V8
         RqK3r0whMrJ00MuQF/PLcG75i4XfuixeO6SzD+Is4NxKfbPQOTsHYaZsVMHRb6gO1Rcy
         glGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TiKnp6d4A9NoyrvVfBTW7z7jtwVDgy0Ld9EMWJo4glo=;
        b=QaDbQ1thNSwBwm9OT156aO2htWUi4fkAFuQbVZ5FOpBP7WRB5FWGgfKRUgEmPnEkn+
         CiTMjYyXfB+zuBZ54yU0NgBL8+RId/uwNhOVMC54tn+rngJJ+3tl/YddUi04/z4sTRLZ
         70BC8FdMa0Nn5Fp1h4QYKzOdAjxkPCVnNt/qdKGdO8t/dv9FasFvo7mVY69xRJLT/nIE
         jQrJ6tJ4Ak2CqPcX6/oh/HbhNP3UqcVZzec3/UmDif/EPVx7d9+MsHxPceGqBL8X1yVJ
         Sw+zgZaK3SnI3twg6RCx+kO0JekO0/DV3GC3YrdnWNn17ftD0LGVxPbGh+l83IFgxmSr
         Z5CA==
X-Gm-Message-State: AOAM53259xjeWUSFo6oHyMQPPcIHvnzr8DuI7g0+7BCxg6BA4uk94fYI
        rCiZkdz/nr2YAv4rhcmA21E0iNc+rViBtfBwpb4=
X-Google-Smtp-Source: ABdhPJymt7xkR3VYvWmZTriwQm2BOYOa4rXZT365G4ahegBQsy020Noy2pUG9dXrXCTdlj0o7/QY8ImYswF0j7QIyaE=
X-Received: by 2002:ac2:5101:: with SMTP id q1mr642527lfb.427.1601464322712;
 Wed, 30 Sep 2020 04:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <1601460480-4259-1-git-send-email-u0084500@gmail.com> <20200930110508.GE4974@sirena.org.uk>
In-Reply-To: <20200930110508.GE4974@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 30 Sep 2020 19:11:51 +0800
Message-ID: <CADiBU39Y-WVCy=8p80fGupB+=68exAY-Oik5Kwap1_jyCR=PTA@mail.gmail.com>
Subject: Re: [PATCH] regulator: rtmv20: Update DT binding document and
 property name parsing
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com,
        cy_huang <cy_huang@richtek.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Sep 30, 2020 at 06:08:00PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > 1. Add vendor suffix to all proprietary properties.
>
> You should need a driver update to match this one?

Yes, sure, I describe in the change item 4.
Do you want me to divided the patch into binding document update and
driver update?
