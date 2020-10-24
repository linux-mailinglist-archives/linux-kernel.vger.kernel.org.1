Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BC0297A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 03:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758405AbgJXB30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 21:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758378AbgJXB30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 21:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603502979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogycSequd4RWbLt37l5/NyaOWw9tEvhtrAKSAsPiEMw=;
        b=K9h4Sf5JolNxJlNzdnUwpN03CxNtKDKEJKh/o/7AdbV8S0KKFWXQZ/Cwpzf06zFNeK5sZ7
        hbEkQ+u8BkbfSZrY1ymUHdlFrwSPJoJ53ITgd5hKoFB0Uy0NpRUgNhk7+hBa1Q9W+vp/dA
        Ho0EkgIL8jmRrpFEXLkUPjs+/mSvLP0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-uxiaPhtaO3yz0hFJnyH7OA-1; Fri, 23 Oct 2020 21:29:37 -0400
X-MC-Unique: uxiaPhtaO3yz0hFJnyH7OA-1
Received: by mail-io1-f71.google.com with SMTP id t187so2892871iof.22
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 18:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogycSequd4RWbLt37l5/NyaOWw9tEvhtrAKSAsPiEMw=;
        b=F7mGdtEzRphYdbBEaxDyBch/NUMAp+a6RMUrjuFifNMizK9ozGoXYi69N/FpWV/MED
         NW9qCzeD2dpJvErOflxiN7HmSSSwTblx12+KRkk/ARtZ7LuQaOF93eWNGYlsxY6AvhoM
         9BqvDw9kjbfBwXqD3mCHpIOrnKNscIJFyx2ZO/M7e4Fqrm4jELQbV7ZE3U7fFsxsmj/W
         1d5RK8I+TUy6lrqtJ4DHlHb24uVPGJLnD3OHdXkO7t080zwWljRc6OtQc3eyy5RvSQgC
         4MDBTag/MZWQ8nOIUQ2/EiVcEwSb3voMZwwK8vPYde6PCR+vvtNhq7EF4RS7Nb6JowFt
         pioA==
X-Gm-Message-State: AOAM5337ERwqfmX2JZpeUqJ8XFHSzSv6gTsL7be5I0a8wZStKHJsIiYJ
        OX9igMZjKN8cou5UnftAu+r8mHzks6lIMK+ueSDjtmwWp2ZUGJ5yU29MHOToI+ZSMfIpCzJfrJ0
        gwsT6Zrye7oqc+jcUqw3YGqSOrKDbFQk9/URqFbus
X-Received: by 2002:a6b:b2d3:: with SMTP id b202mr3802841iof.160.1603502976601;
        Fri, 23 Oct 2020 18:29:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL9cgjj9msggBKdld+zc3mavGBv95bE1zEnc9UIG56vqccc9hNyG8nL/Sg+QJaV3dufZIxfd4ReLL9I0jiepM=
X-Received: by 2002:a6b:b2d3:: with SMTP id b202mr3802831iof.160.1603502976385;
 Fri, 23 Oct 2020 18:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201019093356.7395-1-rbergant@redhat.com> <20201019132000.GA32403@fieldses.org>
 <alpine.DEB.2.21.2010231141460.29805@ramsan.of.borg> <20201024000434.GA31481@fieldses.org>
In-Reply-To: <20201024000434.GA31481@fieldses.org>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Sat, 24 Oct 2020 03:29:25 +0200
Message-ID: <CACWnjLw_EJBnz9ywkg=-7HVScJT1gKRmYRda1MWUrPYTWkHXzw@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: raise kernel RPC channel buffer size
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good point Geert !

> How about making it a kvmalloc?

I can post a new patch using kvmalloc, Bruce looks we can also
prescind of queue_io_mutex, what do you think ?

>
> --b.
>

