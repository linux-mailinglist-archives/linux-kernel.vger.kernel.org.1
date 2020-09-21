Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8727331C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgIUTqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:46:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD114C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:46:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so12131681ljo.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O12KA4gpgToULD4PEEiFpucgyTXt+AD9I01ESnbP5BA=;
        b=Yc+fNIB55As9EBStdgZeN5V81wLA0O4LLOri5v6nxAqW2Ne9yFalKF0kKRt2fZRmXs
         kQQrl+rPZpGeMP8t1q6slpTqtqWj2fWWHnyXL0i4LVExozcWy/FBIayrv4hER3Ye9WYQ
         N0GCH/VJqsPMnMsg31CNnkyIVZssjMPy1KtVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O12KA4gpgToULD4PEEiFpucgyTXt+AD9I01ESnbP5BA=;
        b=sWOTNi/5ci7vSS1F3EiMvXCsMDb9Ii11dj5qRCQ2FRZ5xD2nbCWYqs3QfzFlnMXElL
         TlhEvAF225zRi3PIR0eWcOvMNAqwH3wWtAeAznzM/ihMFpbt/5+Re+NL3nZSDkLP4+6v
         +5pkv36cfVMrMLlJkE7qASGmsES+iF0lwV+7RdKPnyzEAJu3Xfmcv5wEdhBprpFmHzmH
         um7fs9ZEGNC/fXq83jBqmz9QXgiI9hthT4NN9ro0tOcIkqYJbGE7bdu3Zq7S8jE+rlSg
         4WPFhcUjq3iCWyU87Su6acm6b7kqKMo3yxZ1gdPhTdsKlsJ1z4qGRO6s1YKGBkr5WmyL
         ST4Q==
X-Gm-Message-State: AOAM5327PWjRkHCzFqgBYcJ0OT/BNtt0uOCJvan3SM+dR9bJyIqnSQx6
        HOc5SRMFiJe8QCjSaqpY9wGhIXyCXjU+Eg==
X-Google-Smtp-Source: ABdhPJxUb1vaW4ThHjK4xLJo9wiFmq39MwRKIQ6WeBD+l5eEZM1szX9mjPHFz3ucG4Ej1Ri08/QxaA==
X-Received: by 2002:a2e:90c3:: with SMTP id o3mr360062ljg.147.1600717599828;
        Mon, 21 Sep 2020 12:46:39 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p7sm2809490lfo.256.2020.09.21.12.46.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 12:46:39 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y11so15397020lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:46:38 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr525249lfg.603.1600717598578;
 Mon, 21 Sep 2020 12:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200921193703.GA20208@paulmck-ThinkPad-P72>
In-Reply-To: <20200921193703.GA20208@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Sep 2020 12:46:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh52SXRqz9CndHZqjuA1GO7MDdNusQ7CgDOpLkD8ocZaA@mail.gmail.com>
Message-ID: <CAHk-=wh52SXRqz9CndHZqjuA1GO7MDdNusQ7CgDOpLkD8ocZaA@mail.gmail.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Fix rcu-tasks compilation warning
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> This bug was reported by Laurent Pinchart (CCed),
> who would like it fixed sooner rather than later.

I'm assuming that sentence and me being cc'd means that you'd prefer
to get this merged directly rather than go through the usual -tip
shenanigans.

I've pulled it.

             Linus
