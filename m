Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC62AB38E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgKIJ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:27:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:27:39 -0500
Date:   Mon, 9 Nov 2020 10:27:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604914058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWvFcEDucGBOutvD35R+xglmorIXkBz4Wng/s1so8n4=;
        b=A0iaEko+yVzDtFgIbU6fOIlreWEhveQ224l5iDs7Kka8FASCK6xnS5XOBV98HS8NTtephE
        +80zRAoRUtFrq1d9gy3Cr2JU8G5ioB2IvYDFeVm1XJSHyvqIkCAt8aqXtD3CPo19dvfrAi
        ob7yZcyhnGuPtclS7XHQWPH0w4UOgii/DQX23DFEgafkF25jBXRprBNF/Glj2EKxnoC3J0
        N5jbisfJ4MT2Qvr/aueloc6DgtrR0EGgIAi3fsGbQ9WtHF80+8EU4Efd8DYVU+ZRn2kYU0
        IZ1s5eCuoM+Fgcw4SsGrhRxtYpM8odjnp7HCUXjKXsf71qLucwmTOmT/90FU7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604914058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWvFcEDucGBOutvD35R+xglmorIXkBz4Wng/s1so8n4=;
        b=RvV4U39wmiygmrV7JGNoVc6OhOBOms/7zrgtm4WyTqGVawogRR63KeXnUXy5dvrS03vLGU
        5O6WdS0LrG+hyFBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RT 6/6] Linux 5.4.74-rt42-rc1
Message-ID: <20201109092736.bsd3rgafncf7cbxk@linutronix.de>
References: <20201107020636.598338441@goodmis.org>
 <20201107020728.592479947@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201107020728.592479947@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-06 21:06:42 [-0500], Steven Rostedt wrote:
> 5.4.74-rt42-rc1 stable review patch.
> If anyone has any objections, please let me know.

The remaining queue looks good.

Sebastian
