Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068F92C617C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgK0JRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0JRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:17:35 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41CC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:17:34 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so5850629wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gvSmh42j+Na69d8tYP15USmlAiPkewESLNzSugoG51g=;
        b=fz5Y/OBDWubrfIV5wC3zKsGHvULPNFb3V3LeKRP5jZ7ACpdD78UbvC+3qtNTDyGiWX
         O0O47JNeqYIjiAOXmdTgG7hu5EtAvjkuSwhcZtZXLJ97XTsmdbA8gpdahyk78uVHCrpj
         m7vt7HNmD3hSFr8Zq8SZ0eayoZaKeWyLbtTkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gvSmh42j+Na69d8tYP15USmlAiPkewESLNzSugoG51g=;
        b=M2BLE1mDPpxsTe4o6ix+CjEDivfc6ag7q+VyAX3kVIxbNKUpsc/iH3XKHVrTMuByR2
         Vd1md+aycbEmSe1PjQyErCjJvcWv+G7YPy15WGIwvFlytvVBHnZpKrsgQxJGbdUowvK+
         Tzy+6qfxCNqmgdflu+YO9Gyybg4Oux3DO3QHoUb2+9JD8qhU677PeTpDb5+dGXhj91hY
         j4zuQ0CB2ahU4aRW3DchH4mjjKEVM3YPJu5GF+LaQWw0YAN5cjfw9DcUVXSPei3Se1PI
         1jPMUPQYU/Yi9koO4NNqzhgLcAfcfi7En8vcLOKn65w9iLUG0fyIMiGfMtVVLfYkElEL
         /aCg==
X-Gm-Message-State: AOAM531e6Zi5k2RaaCoGcimcygJ7YzpyWPUIeQN3KrFQOkZQQYA6Pxe2
        yf22QXxXHj12bIVi2ChSi9B8vA==
X-Google-Smtp-Source: ABdhPJwS5KZGFOuX8YL+/zY/fdyGq42H90XEm3tgLHgp8cubkhwx+xPy/BmkaApl0jERo6H1UsjkJg==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr8009006wml.155.1606468653404;
        Fri, 27 Nov 2020 01:17:33 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id v25sm5456639wmj.27.2020.11.27.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:17:32 -0800 (PST)
Message-ID: <540fd8fd4542c9737224a43fa4123ceb679a7b59.camel@chromium.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add a selftest for the tracing
 bpf_get_socket_cookie
From:   Florent Revest <revest@chromium.org>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Nov 2020 10:17:31 +0100
In-Reply-To: <8b0529f0-5f1e-b403-2772-7a56c44a3a55@fb.com>
References: <20201126170212.1749137-1-revest@google.com>
         <20201126170212.1749137-2-revest@google.com>
         <8b0529f0-5f1e-b403-2772-7a56c44a3a55@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-26 at 23:56 -0800, Yonghong Song wrote:
> 
> On 11/26/20 9:02 AM, Florent Revest wrote:
> > This builds up on the existing socket cookie test which checks
> > whether
> > the bpf_get_socket_cookie helpers provide the same value in
> > cgroup/connect6 and sockops programs for a socket created by the
> > userspace part of the test.
> > 
> > Adding a tracing program to the existing objects requires a
> > different
> > attachment strategy and different headers.
> > 
> > Signed-off-by: Florent Revest <revest@google.com>
> > ---
> >   .../selftests/bpf/progs/socket_cookie_prog.c  | 41
> > ++++++++++++++++---
> >   .../selftests/bpf/test_socket_cookie.c        | 18 +++++---
> 
> Do you think it is possible to migrate test_socket_cookie.c to
> selftests/bpf/prog_tests so it can be part of test_progs so
> it will be regularly exercised?

I suppose it's possible, I can give it a try :)

