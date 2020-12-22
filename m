Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFA2E0A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgLVNTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgLVNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:19:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC0C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 05:18:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id f14so1291020pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 05:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+gbc2CqvgZj+5ij6o3Cu101R/iuKhpMX3sKpHEpakwo=;
        b=e7LEqkprwtC2ftOjcXddyMIJDToqaQhHK+HoWaZH11tpWDXWttmNQnTR3dhpBQlnpl
         gqCb+HiXoZZQqBfqvLepbxau/l7WU6M98TJ9hHRcKi7ATHUF/9dTruXLB2wUFtiEyNGX
         2OnVshzZp8Fnva+zWTc/8IyM5OIjehWMo1/biib9+IfuFXrFORXukZQP3lYultsincAw
         s5EuBCR/Yy6iv3pdgIRZl6IW9xchtVncLcpn4o6iWd5BSocvGkXNYoc3aZzHXbrq0TU2
         YqfMPF+TxppMKZxhFHLkbtH0eP1aSe/1DUmKyveZfQHiGXle1FRy4t2QOMkCmS1cjKqS
         afvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+gbc2CqvgZj+5ij6o3Cu101R/iuKhpMX3sKpHEpakwo=;
        b=oJ5qLAzw0Hphzu3cOhIKI8xnlQMnnZ5ClV/UOOou9LN+806jERIT7O5/y49Y9YHtkL
         ybP9WD76epcHwmifyVVN5VxZX2WRhlzO+vu2wH0RKU9Ru2gyJ4FK+XAd2imRMGQvJ99S
         fH2mGuF0oWQaezptZNl0u4OkDLiDlik8syrmno55W/CjpvYDEtUxWNYro0Y0pfF1uHX8
         Hc4Y6A+M5uHZjL/+nUBUdNnd7Z2Ji7B8N6xvWviwEGAp6ICpn3GxKvdqtp2bsZCenzL+
         uTaRg3/7RUnD1phW35TehLoC1QQ+8OeKHRlDS/DoJ4oF0aoyc+f/k0dkR/Ir+i7rnYyC
         AE8Q==
X-Gm-Message-State: AOAM530VDAJ0g0vTWR/1A7AFVhAnMrjYqY4rxBW1EJycEyuKgUV6Piw/
        ML3EIHQwREM18jiIGQNcYKBVqOpNEB4=
X-Google-Smtp-Source: ABdhPJzalw3n9i7QryOGNTZ9LguC0n/AmX82UM6Bjz0Gl+TMxnydu0+oJJ5Yb1dau1LkM+fWIxyiHA==
X-Received: by 2002:a17:90a:c910:: with SMTP id v16mr22017153pjt.198.1608643131678;
        Tue, 22 Dec 2020 05:18:51 -0800 (PST)
Received: from localhost (g39.222-224-245.ppp.wakwak.ne.jp. [222.224.245.39])
        by smtp.gmail.com with ESMTPSA id l190sm20234146pfl.205.2020.12.22.05.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 05:18:48 -0800 (PST)
Date:   Tue, 22 Dec 2020 22:18:45 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Karol Gugala <kgugala@antmicro.com>
Subject: Re: [PATCH v2] openrisc: Add vmlinux.bin target
Message-ID: <20201222131845.GJ3168563@lianli.shorne-pla.net>
References: <20201222070731.491076-1-joel@jms.id.au>
 <CAK7LNAS_+VTDspmBNXPZzMKDhzDz9+TyKjrOs_Xho-ZMEPGDKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS_+VTDspmBNXPZzMKDhzDz9+TyKjrOs_Xho-ZMEPGDKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 04:22:16PM +0900, Masahiro Yamada wrote:
> On Tue, Dec 22, 2020 at 4:07 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Build it by default. This is commonly used by fpga targets.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v2: Address review from Masahiro
> >
> >  - Add vmlinux.bin to phony target
> >  - simplfy vmlinux.bin rule
> >  - add cleanup rule
> >  - add vmlinux.bin to targets
> >  - Add gitignore
> 
> 
>  Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> 

Thanks, I will queue this.  I am just wondering if I should wait for 5.12 or
just go ahead an send it in 5.11 as a fix.

-Stafford
