Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE026E54A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIQTSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgIQQRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:17:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F60C061225
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:17:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q5so2830071qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRDdNTNIua0HCbm3MCn0pcIszSG9ZVBbCO9Y6jjOxgQ=;
        b=KKG3p8LuTjIR8VB4z43UiojqXjrK+GbySfTQF4f6ZLZ2ujF/oJlKMKNsbsUaPh/Vtz
         1Cj36qvj7vxhb9cM1N7/Eo+RZH/jtUiC8EQOuF0ojzm7d0SI/Ub+WpfeVohemjIxhVC3
         8b4LNtSsLaSrryOqqk9pccpZIBcKyn5aEyembXRjdI1QX67WCiHaBmMaX6sdLC3EuL8D
         bR0zPutE+wBZ9NMnJ6Q66yuLVh2VugdKm1NFIuKMty5baRK/dFcS0boBGgxBh2AlfwUt
         Ia6kibbHIutM7n1eop03gvtspyFK10mTG1mnXsvzXQdCVGbd99o5BBk/1mmz71Kp1Rzr
         xdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRDdNTNIua0HCbm3MCn0pcIszSG9ZVBbCO9Y6jjOxgQ=;
        b=CTpLWqUGa6gRUTakQpdW1kcnMlpYZgnDSmJWqsuR9ylDADLXBZaTe8BhnwkmH5yJFD
         URklXgSFdx8MJ5kD5WUXMkEiaPGpzPByq0x0jgroJ/FnB9QFVEQf0eLrcPxey82Mg+Xb
         s8gbQEgpZSnYa7N8O0Gj1IfOY3T/QZxEzoU3B6SfE7Ro1Hf7UJIkgj5BuSpv3vbeA5d8
         ofIXmt8V1igo4yLbWlqk9KdEf+IUM5qNfDa8x0nr+ZjTKiU7LdQIJvsLG/7ZS7XjExED
         BJjUxsJ67nZBolBKBPqtk8KM5m6xb5rk0ku6u8u5uwgnpffjyv+Y3pMIj/DG+/kdYz4Y
         pLcw==
X-Gm-Message-State: AOAM530eeuVNHn2PJ5klcSzm2OXhiXpxdS1l6nuCVZB44RDEqWZviU3y
        jbE0+HFisxUvTJy1+HcWCZ4u6v5YXslWSGWrH9JJSw==
X-Google-Smtp-Source: ABdhPJyHk7FfUoSZhEiDjpGn8vc9yfIWEwSDGdfFYe+qK5dn4fzTlSJQdfvn9Stjh7lS+OLz6i5sjZ/2gXzd/a/tV/g=
X-Received: by 2002:ae9:f104:: with SMTP id k4mr18530915qkg.10.1600359464772;
 Thu, 17 Sep 2020 09:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200917020021.0860995C06B9@us180.sjc.aristanetworks.com>
 <CA+HUmGjX4_4_UXWNn=EehQ_3QtFPZq8RJU146r-nc0nA8apx7w@mail.gmail.com> <CANn89iJOO9cbOqCNpRK4OrZy-L6P8aJJcPMjs5=RHF=fsjEe2Q@mail.gmail.com>
In-Reply-To: <CANn89iJOO9cbOqCNpRK4OrZy-L6P8aJJcPMjs5=RHF=fsjEe2Q@mail.gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Thu, 17 Sep 2020 09:17:33 -0700
Message-ID: <CA+HUmGihUwWojfEpYHkhj8AqdpA1OKFqD18pOeCiVW5RvmuEtA@mail.gmail.com>
Subject: Re: [PATCH] net: make netdev_wait_allrefs wake-able
To:     Eric Dumazet <edumazet@google.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:51 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Honestly I would not touch dev_put() at all.
>
> Simply change the msleep(250) to something better, with maybe
> exponential backoff.

OK, I will try that.

Francesco
