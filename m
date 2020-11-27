Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A222C6197
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgK0JVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgK0JVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:21:50 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47615C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:21:50 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so4816357wrn.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4haAtXUHa8qd3ezJgcItd1OHQbgYPxsuO+gzkuxGWzA=;
        b=MycJzaG7hTHxWNHLHRT7gLb1N4CWd4edFBx5g/7f2oTSaPmbzk/tc1/iqIIhvyDeWO
         MuVBINQE+vBa4ymeSmrzOACpGRntflnD1ruPWTH3gHMTljUdlCxb41AdeWXCzy3VEHc4
         T+dx8lWWcjRnmoFI1iOhctgKBT5HI0cqaDL+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4haAtXUHa8qd3ezJgcItd1OHQbgYPxsuO+gzkuxGWzA=;
        b=De2eJe24C0Rfk/Rfsn5JskpAH8WnAf44Kzkt28/s71qIL4eqtNdrxmxpgvM4FCL4XB
         pPuMzR2IeGVUXp6ximEsm2kpzN16YHZGzoJzkIH05IlvfCc+abRU83upTM7oVpidU3/Z
         Po3OVfayE6qT0k306q1oc2znSMMkDKFy2SHUNLr+MXSw/D/GYsTS2UBy2KEqgaCN2QLH
         1sA5kKjLQQb+yz0JPmxjv6zyKQ8up5xgSFwPXHhHJ5wKfHdh+Kbl/LxTC1tbUjBlTZfQ
         HpbULP6SW1KWDq9rhwt8F/rMNKmCDCkcuY8hMU8AkS+ElQwLNwAYLb/Ateqrc75CKJPw
         dA7A==
X-Gm-Message-State: AOAM531ZR88Lnire9LaEdz7QU/4nwLnw/y6S6asWiL8V+MJDpZyUo9jf
        PxALuzT1A2sm6yaGf8A19MzZCg==
X-Google-Smtp-Source: ABdhPJxKn99M0WW71ImXjuufXD45kVFE54JjEEPi8DjQ8fwpuMovU1Kj5DqnCtQrCGWP+M0uR3DpEA==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr9228587wrv.306.1606468909049;
        Fri, 27 Nov 2020 01:21:49 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id a144sm13266512wmd.47.2020.11.27.01.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:21:48 -0800 (PST)
Message-ID: <492ad793692d03105f3ac2a2e1a3196dc01e5cef.camel@chromium.org>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Add an iterator selftest for
 bpf_sk_storage_get
From:   Florent Revest <revest@chromium.org>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Fri, 27 Nov 2020 10:21:44 +0100
In-Reply-To: <2c5a814a-7b69-3a8d-e4e0-e595d009cf82@fb.com>
References: <20201126164449.1745292-1-revest@google.com>
         <20201126164449.1745292-5-revest@google.com>
         <2c5a814a-7b69-3a8d-e4e0-e595d009cf82@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-26 at 23:00 -0800, Yonghong Song wrote:
> On 11/26/20 8:44 AM, Florent Revest wrote:
> > +SEC("iter/task_file")
> > +int fill_socket_owner(struct bpf_iter__task_file *ctx)
> > +{
> > +	struct task_struct *task = ctx->task;
> > +	struct file *file = ctx->file;
> > +	struct socket *sock;
> > +	int *sock_tgid;
> > +
> > +	if (!task || !file || task->tgid != task->pid)
> 
> task->tgid != task->pid is not needed here.
> The task_file iterator already tries to skip task with task->pid
> if its file table is the same as task->tgid.

Good to know!

