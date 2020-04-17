Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6541AE04B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgDQO7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 10:59:08 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44985 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQO7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:59:08 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N0nzR-1j45oi1Oth-00wja3 for <linux-kernel@vger.kernel.org>; Fri, 17 Apr
 2020 16:59:05 +0200
Received: by mail-qv1-f47.google.com with SMTP id fb4so999136qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:59:05 -0700 (PDT)
X-Gm-Message-State: AGi0Pub1o80bSk1vS6O4W4fRkE4eL2nUr4StB/wY1PwUiVwXWM8xMwDd
        K9JPC5A9QxdhQemU/I0HkrS2E7I6MxRWO+3cKtg=
X-Google-Smtp-Source: APiQypK6H2sYYYSZKAdSmmfa2MAlt0yW4aUSm3D2h6CUEgVPlGKHt4i/wv76jSZrzUssUtAvPLNxCQopFYs1B7Ph4Co=
X-Received: by 2002:ad4:4d50:: with SMTP id m16mr1321929qvm.222.1587135544234;
 Fri, 17 Apr 2020 07:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200408185834.434784-1-arnd@arndb.de> <20200408202421.GU25745@shell.armlinux.org.uk>
In-Reply-To: <20200408202421.GU25745@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Apr 2020 16:58:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ZskJqBbTod-botFdx9fuWN9q5q25G1Gx=ky_Sg2cuHg@mail.gmail.com>
Message-ID: <CAK8P3a0ZskJqBbTod-botFdx9fuWN9q5q25G1Gx=ky_Sg2cuHg@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: avoid stack usage warning
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     SoC Team <soc@kernel.org>, Roy Pledge <Roy.Pledge@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0Xf3kd8qmZZJP+kgTxOQAPNO3HRa/kWEXxoDs+OkKemmdmv1ZYs
 q65ymTiPADNYa5zUmwZg0c0omckOH4ww2CKNE38h6aN5VQa+fIsvNJMjcAXEmfLLoPXkrXA
 lyepVNeRImIf5UiTEcCc/e5JLAylW2C8G/u4JAxc9j1Fdj1iwc0X63gaRYqe2lAIfndqOdo
 JwG/VoZddd6XXOxsE7upQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uB9wWKXQ4EQ=:TNy9dPS5hhJvgmjXVrOcCG
 g/QMVqhGY961LMRsJopOPGs5KZaRXXUBj2L/8qY7Iktozcuq5h+C1xK3pth2wvwmlA4RAf72P
 Mas1rcpJ0CXEzCEv3+2TTg5fl+AZ2kPoLYMlGSgBpMqovN5AI6DD4GY3kZuSuj7evydKY1YqD
 BMIrHl25OFNcw8aoH3oP2+6a7IXzV+ObD3VqUCrjFsFYivrUlJAZjRB3tMYZZngUFTf7l+iZW
 GFrJm/2N3h73ySpyghW77tGh2y5SAWTFnOmZqrGJn5SCdQPUrZjj1J2xOFAPiCI3HBlr55GWO
 Tln3olNuOlfo4ezsPaq8iqY/6MvjjmEEOanDFQOvzTDcxAd1Vace+qVjXePInH8VEO24zkb7N
 +GRcSCBsVP3Fc2iy37Bfy46TJttSIZtyx0+IoiWsAgoc3MlTtgWZK56JQcyTkGBAw8MqmpSIA
 Z9q68US7waDOzXQOUgOEIxMlznT8T+pP/5d09sAr6w1djUa9OXazJeiOPaSPsjRWHCjxc3nrn
 axBsDWazETErR7+x8dK55uzRVOJ2cpQ/CBkMEfSmHgKjwE7qiyRj1Q+wJ1Y5MUmj4G9ga0nya
 LcrSjAOQVsS6EUOeJDX/Fb3oWhtWUT5Ary10YHcbPgkEoe32dTzwTnAmo/HY0fqvdSSOUynaW
 ZPpTmzuiHOIefmvRslfYLJ4kS/XBjs85V7lGytXWDPr2nThgy4tkjbMiMuq2rQ8QV4D6Z0GuK
 gtTZWWaV7b58nbsxEQffE3NQhZ8L46a//5w2/PMY3EquxgxsUpVVBMZfWvFoPSnxhPC9RY/gj
 3QcQ9EK+Jl6SFdsp9hrtv7c92NHSJwoy3aE00jXJjlMZYlqw68=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 10:24 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Wed, Apr 08, 2020 at 08:58:16PM +0200, Arnd Bergmann wrote:
> > -     int i;
> > -     struct qbman_eq_desc ed[32];
> > +     struct qbman_eq_desc *ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
>
> I think you need to rearrange this to be more compliant with the coding
> style.

Ok, I've updated this now to move the allocation into a new line
and applied this and the other fsl patch into the arm/fixes
branch for v5.7.

       Arnd
