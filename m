Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B1D1B81C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDXV67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 17:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXV67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 17:58:59 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55F020704;
        Fri, 24 Apr 2020 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587765539;
        bh=i/eRxJFitLn3WBdqf/djBBLjo2O64KugNk0Okb1pO6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o0V1nEK/aEBCW9KdFUZfhzPWrOdFmeS9BF4u863JcjAwjr41HhVUvJGUietVZexfl
         AZdrLFuHhqIri4fWsm+5DGIx/TqWFNWoM+QWx5EpRvAfIWAQimOakMT0bK5h589/WC
         8kKCrL+BI/bBZYGUMHThvWXRO4sERcKRFcIcXVDg=
Received: by mail-qk1-f176.google.com with SMTP id n143so11848497qkn.8;
        Fri, 24 Apr 2020 14:58:58 -0700 (PDT)
X-Gm-Message-State: AGi0PuYi8b92e8rHvqaK2RO+xqcWSRBAoxiOy/WSsv2OcGvvbRDsDq6/
        CHlJW8wRr+BYaItyBp71lQW0JUG1MiwXevyeYQ==
X-Google-Smtp-Source: APiQypJLPJndlsfEhyT5cmRrWxsBCwpwqrWKNnFyjkwqpViCDkphSt5ytu6p5Gvpjy74VSWFhqLjepwMIbdkghSoBHk=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr11094656qkb.393.1587765538013;
 Fri, 24 Apr 2020 14:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200423064808.10468-1-etienne.carriere@linaro.org>
In-Reply-To: <20200423064808.10468-1-etienne.carriere@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Apr 2020 16:58:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+zNyqcQ2xWceGLz4by=3rV=46wPyj=HcFPZ9pQPF17eg@mail.gmail.com>
Message-ID: <CAL_Jsq+zNyqcQ2xWceGLz4by=3rV=46wPyj=HcFPZ9pQPF17eg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add examples of secure- prefixed property in documentation
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 1:49 AM Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hello,
>
> This is a proposal for adding a bit of description in the DT bindings
> documentation of how secure- property prefix can be used for. The
> changes in this patch series describe that for clocks and resets properties.
>
> Documentation file arm/secure.txt already states that secure- prefix can be
> used for any property hence the description proposed here are not mandated.
> However it may be useful as explicit examples of such usage.

It may say that, but any new property has to be documented and
reviewed still. I'm not sure that anything in secure.txt has actually
gotten used.

You should participate in the System DT discussions in Linaro where
how to represent different CPUs and CPU execution environments (like
secure world) is being worked on.

Rob
