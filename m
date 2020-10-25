Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07955298093
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 07:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767633AbgJYGLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767626AbgJYGLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 02:11:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A2C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 23:11:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so7977463wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iQdJQCMJn7+Ib4L7UUsX62v/7dWGCsK4jU3a8CuDpUc=;
        b=Gl4tK/aD13wQK8gnRuTkf8SLuCqmqCR7cICqZcp//0ffhzvLP4RlByMJFEjg0DlEZz
         N3iV7Xb3kyn+zj0cfAtD21QsRXeHDcawPUpTw2xMonr+bTxc7j4jDoPhu+UOFV74/79k
         ME3G4mZcYV4KO4hdK8dWZ1DuZAkzzKGMIfMk2V2HgtGBZy9V/dFrG546C5Vj2sCEM645
         /3ATUch+APiM1UdL4IxZn8w3OOBRfEkF/88EWeN9raNlvYIMJMEB1WtAlsdb/6UnCTS4
         fYs3x6Uoj9N3IrXCoBEmbtAQLDLbWvue99KuDNe18x72ANl6AiNJUQEaT6NyYkT9Tkb6
         rhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iQdJQCMJn7+Ib4L7UUsX62v/7dWGCsK4jU3a8CuDpUc=;
        b=kW5fkaK0qcbn6QRCPom45BgCLb7FntbHo1rOyhC+aD/awjG3+sZtq3RtG3w1E43HDB
         GomPpMtDCZE3t85LP6S57ay01tFj+P8HTAWhl/qbKJVIVJlfleBRY8RxPaGEPf2M0Dlt
         XxKhFF6zJS6pHF9/uzo4wTPJ/a/TTuKWJFF9yM3kmVtjYWneoehfPFSWPbvAiGSYBOjv
         bylnRXttIZDO2+If1wWrUv6+hsAKktvgF2mPySp5BZWwU6iBpTJMtSCf0EGy3e2nrtXL
         urrldRYmleXpH+k6e6lsl73V0kiosuMO2jcpd5Xg7XpbIYH0MxibD8eUAwAR+R4juRD3
         Cqng==
X-Gm-Message-State: AOAM530+dwTMiVbtYryeGX3iaWEYmTa2JrL3eDcLGjoDQiJXAZDYubd9
        CEUfrCsRs6bdSUnGw9qCTQQvTeeiDXM=
X-Google-Smtp-Source: ABdhPJzZQxw0X0Au43l+lLZhSs2wD1x0gNw4CH23E/KcU8yFrepQnIAKfOmFsIKiBs7B2utbiYt3vQ==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr9903406wmi.120.1603606302494;
        Sat, 24 Oct 2020 23:11:42 -0700 (PDT)
Received: from felia ([2001:16b8:2d75:ef00:cd2e:52e:ef1c:926])
        by smtp.gmail.com with ESMTPSA id w6sm8744478wmb.28.2020.10.24.23.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 23:11:41 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sun, 25 Oct 2020 07:11:40 +0100 (CET)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Aditya <yashsri421@gmail.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
In-Reply-To: <252e2adc7ae9e2886171189f1421e2fe3c33629a.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2010250708050.6697@felia>
References: <20201023133828.19609-1-yashsri421@gmail.com> <alpine.DEB.2.21.2010232104150.11676@felia> <c9512657-d7d0-bf04-0e40-b3463c9f5e1b@gmail.com> <5c11f284872f3b2b017d9d27d4075582c1a40eab.camel@perches.com> <alpine.DEB.2.21.2010250627370.6697@felia>
 <252e2adc7ae9e2886171189f1421e2fe3c33629a.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Oct 2020, Joe Perches wrote:

> On Sun, 2020-10-25 at 06:51 +0100, Lukas Bulwahn wrote:
> > We can identify a set of rules and clear automatic fixes that
> > maintainers can simply run this script over the patches they pick
> > up when they pick them up.
> 
> checkpatch --fix-inplace does that now.
> 
> But realistically, this is more an interactive bit that IMO
> should be a separate script on top of checkpatch.
>

Agree, and of course, we can work with some maintainers to find the best 
way to combine that into their 'pick up and apply patches' scripts?

E.g., some might be using b4 and we simply hook into that in a friendly 
way.

Further just documenting the potential options for maintainer in the 
maintainers handbook might also increase adoption.

