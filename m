Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8628E671
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgJNScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgJNScz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:32:55 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2025AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:32:55 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c3so121129ybl.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=atNVlH6irrx/d183AJFwkx780asL0iHEUrSJ6WHJ9yc=;
        b=KO6V0+jy5MSu6HfIesopDuf0HYsLMJF4iB+FFLjEgefyl/V5+/IJ2u0OfMNXzTSk3X
         4rBv97O9CKqElHhCXOm/sASazgXZ+oFBJg5rNTorbO0szyxmZmvkV2d3zHCQvT1fF8we
         O50SzPEBoFhlBm0sobzc6zEZ/B13iZIauX1dqsZYf/uSfJGGWxiIOeHNyrURb53IXtQY
         Ve4yhba+GK8+B1V2ohVTFJtWyxItLj9PWWZEeUKhVI1QwmHGxs7hbw+qsZqLGf2sPfSI
         75KrNb1hUksajh1Mict4Z1bDSmabfNx/a1KQ3Gpco4jamDdfR8aLQteeoMgm6vGscipU
         oncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atNVlH6irrx/d183AJFwkx780asL0iHEUrSJ6WHJ9yc=;
        b=CSPmom+DtjNlQjSWKG17SMYPrrLAaHmbygSs3KeDQIWQk1PFNrl4WqM9jKbznEeORp
         j9vzYPjg/MY5iTzqFor0Mer8yw01hGv72nRMb0NaACclgVZvwFRbtJEPn4HFdJb7C+n7
         JodzGk+vZGlCXKLFHAB82VouWpzhjiVuYBfhxIgpFSVeozqoLDZfu6WCkBwTAEX9AJdr
         bcRHt78qY34mEF8jrrWaQI6cXHFVfHy86uxyue8fl48CLrBrr/tYehFJ+ZXnPNprb+4P
         R3ApGN6+PldL50T7qQw1tjV0jBEcRGJD//bDSQgVf7KHHiCLYcbDrZyGqE+VJrm729ui
         184g==
X-Gm-Message-State: AOAM530TgQd9iao6FXoO/qKQxLM9w1t2nUwSp7YhYvDX+RhooBQZkg3w
        P8+bT5XgMVNt+baFsodi7KOnquv1TahhQFDBzKW8dUcpKZA=
X-Google-Smtp-Source: ABdhPJwZ2gPHftiwCqEtjOWKle33rGuXGLfcqNWBJ4jkWev+2n+cSU4SpOc/cvGesvc4/N9ngP0IByDPrwZ/7dpVi34=
X-Received: by 2002:a25:3b4b:: with SMTP id i72mr132415yba.22.1602700374479;
 Wed, 14 Oct 2020 11:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
 <alpine.DEB.2.21.2010140734270.6186@felia> <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
 <CANiq72kogiVbBURCrb74_vCPCLb09LGTudxE-QG8US7pX8LqQw@mail.gmail.com> <fc0c8503257ab6593ea8a1250ee3ac083a4ab5ee.camel@perches.com>
In-Reply-To: <fc0c8503257ab6593ea8a1250ee3ac083a4ab5ee.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 14 Oct 2020 20:32:43 +0200
Message-ID: <CANiq72nNkqu2a0KoDoj7Y0K2Ud37Ode5U9ju7JyPTtv58QJ3cw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to EXECUTE_PERMISSIONS
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 8:05 PM Joe Perches <joe@perches.com> wrote:
>
> Any 'formatting off/on' marker should be tool agnostic.

Agreed, they should have used a compiler-agnostic name for the marker.

Cheers,
Miguel
