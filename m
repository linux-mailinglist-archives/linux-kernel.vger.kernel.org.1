Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6DF273F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIVKUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgIVKUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:20:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70BFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y17so17410132lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vhjc1EER7uN9DWQnxSHbUtNrZtZFBWoK1DQ59kiO5gU=;
        b=FS8sD2NISzDt6t0ctSUXZl+k5iD18VFWjO8g99m7nrEyOn9gVpzf8dKA76C57w58vu
         eP/hq+T+tNrjAW4Gsq1wsfMLzXmbC50Vo6OZezx9/ScWXLGXWNK1F3f/oRICaiTkRwtB
         UVESb7+uDM9F+b0Ol1GXJ9wIuspR/rG0m4ng4O+ohbq6qOMZSLp/CBxHYx25B3qAqsT2
         DM/y1KcgykYAE5frsyVMApHg43NX4e4YB1yBgFlcqht40+3g7Gq+4aEEhZ5t8A3/LgC4
         uiBu7FyBZZuRpKnj0GLNYVUbymSUJHSTGHO8Yw49VgBk9/xDi1APnjzbRdIz2K0H4Q2v
         gsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vhjc1EER7uN9DWQnxSHbUtNrZtZFBWoK1DQ59kiO5gU=;
        b=Dp6NH5xp+sT5kbV/vpEzsfnfIbS2yYbp3sEMNY5olbelTfAEgZUX3nNMIH6gpUV71Z
         ssUU7tuIcm3LF2VxmmS8IQExAAgyiQOvV3ORLCAuXrNNcUSiFpIGagFlrK7Esb01O4vS
         frxi5SRuJJ/uEq5K4560sOEiwiZZnYDE5m8zVr0tqA1s1GpB2Vzt6IyeD0hzXoegKMsc
         Ul3lH1oUIwhCHjIbZccnkoIspUUpeqOszwrm9OrtH7KBVXDq7rKXn/cPxurHp5foezFi
         wpo3qvN4+J5to+rOME78bK3YgZ2BbTIYiwDXjk5e8vK+0Mm5uvtXZtNCKAg7KIvXuW+I
         tyiw==
X-Gm-Message-State: AOAM531OfLmLRcZUjwjW+HCcMrQyTrdrFhi0oJTEMO+OTP1DD5ucKNG0
        OoC+x33PEzwpIYYGcpPgE6GzGde4Do8UXAHAYNs=
X-Google-Smtp-Source: ABdhPJwVbq+zB2UgcsZr4G0xJvStmxP51sffKut3zOGfVy2jP71n5cZ1hZ6ZFrN46pWfGMcJWqXsSJJvQsIcqYP6ICs=
X-Received: by 2002:ac2:46d1:: with SMTP id p17mr1567806lfo.216.1600770047143;
 Tue, 22 Sep 2020 03:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191016082430.5955-1-poeschel@lemonage.de> <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-32-poeschel@lemonage.de> <20200922052701.GB16386@1wt.eu>
 <20200922094422.ucj24ohtervhcetv@lem-wkst-02.lemonage> <20200922100400.GH16421@1wt.eu>
In-Reply-To: <20200922100400.GH16421@1wt.eu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 22 Sep 2020 12:20:36 +0200
Message-ID: <CANiq72kS-u_Xd_m+2CQVh-JCncPf1XNXrXAZ=4z+mze8fwv2kw@mail.gmail.com>
Subject: Re: [PATCH v2 31/32] auxdisplay: charlcd: Do not print chars at end
 of line
To:     Willy Tarreau <w@1wt.eu>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars, Willy,

On Tue, Sep 22, 2020 at 12:04 PM Willy Tarreau <w@1wt.eu> wrote:
>
> The points you mention are good enough indicators that it's extremely
> unlikely anyone has ever used that feature with these drivers. So I
> think it's best to keep your changes and wait to see if anyone pops
> up with an obscure use case, in which case their explanation might
> help figure another approach.

Agreed -- Lars, please add an explanation for the removed feature in
the appropriate commit message and also mention it in the cover letter
so that such user-facing change (and any other) is documented.

Cheers,
Miguel
