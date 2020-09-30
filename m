Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD727E54C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgI3JiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgI3JiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:38:06 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75224C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:38:06 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id s66so1196461otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfzEw5x0NiRRju3CPhetGru5/pRnoeNXGN+8SqIx2Xg=;
        b=xSNlabK0wj27CX+1Qcx2VTudu5ZW9FuibpTZ0nWLnP7KiZc1Y26yZKB8Eh31WGDcm6
         8swxBpO09W7KLsdWCfcJLGpNOa9gUdbATUzXP1GsumP4vcMrlnAxEcLj8eox2M6rO4QT
         LYOYeyB9ved5GDo1QpgQlQh7SernXIJ3tBNMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfzEw5x0NiRRju3CPhetGru5/pRnoeNXGN+8SqIx2Xg=;
        b=q09rRFihgCdEkisYWtJ9e//CMnVmtaoc9GnPIJDatUH2fnd8P33uhyXxC6X7dUK/zU
         jz25o4s38VlV30qyrTFWasOQA1L2WkXICcAuEGV2limNJTAfpWkkaN2J1bS4QXcQ5Gao
         t9kSe6R3+JihlcSeBDm4EzxcK6D+5RhgNTM/VgNLsxV77eP6Fl/sybRl9ckjRhlPSyi+
         jDk0aRee7cI9JvpH4ro0v+MbW7BNy+O3aRPIaYWX6u6Mb9DjQ1M70OZYc95bKIOTKYTD
         orzuqm/WyjgyhK4lCXxyIXxp9JS7eKMGXtYNc+IASuiVgwTSflG5s/ZBbDILtmHjtcZN
         yHoA==
X-Gm-Message-State: AOAM530dTt2IYZcXshCPJD+lXqhpGgk+IZEATl7mCweL7PeUthRn04D+
        UOnMem6CyW4Z7RetQfaX7KNbk+lbVB5mX8X6etDZIQ==
X-Google-Smtp-Source: ABdhPJyEFIY605VtSWbEn3ZkRUtaTSsucUs4nlzLVLBbPX+b1HdTLS14fXU+7V2yAvC7hyiex42j1bUzvOLQo1flGe0=
X-Received: by 2002:a9d:6e90:: with SMTP id a16mr962799otr.132.1601458684868;
 Wed, 30 Sep 2020 02:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200928090805.23343-1-lmb@cloudflare.com> <20200928090805.23343-5-lmb@cloudflare.com>
 <20200929060619.psnobg3cz3zbfx6u@kafai-mbp> <CACAyw9-hSfaxfHHMaVMVqBU7MHLoqgPyo55UwQ3w7NKREHcCxw@mail.gmail.com>
 <20200929172340.hogj6zficvhkpibx@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200929172340.hogj6zficvhkpibx@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 30 Sep 2020 10:37:53 +0100
Message-ID: <CACAyw9_wfD39OCKR5zMN4g=GjcYH31Dg7skoyhPVHVTspgvarA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftest: bpf: Test copying a sockmap and sockhash
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 at 18:23, Martin KaFai Lau <kafai@fb.com> wrote:

...

> > Yeah, I think so. We'd need to do something similar to your
> > sock_common work for PTR_TO_RDONLY_BUF_OR_NULL. The fact that the
> > pointer is read only makes it a bit more difficult I think. After
> I thought the key arg should be used as read-only in the map's helper.
> or there is map type's helper that modifies the key?

I don't know, that's what I meant by more difficult. If map keys are
always read-only like you say this would be straight forward to do
(famous last words).

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
