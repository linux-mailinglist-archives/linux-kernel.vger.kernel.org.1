Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132522AC22F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbgKIR2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbgKIR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:28:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:28:14 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so9585161wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnNpAp3aE8fQN7wBOIfnQYPkKJsQ6+pg68kkULOUDHI=;
        b=geiVEhhOsPRn5fpk+li0RJgnq1L0ionzhCXrha7IGd1d7QViy61+BQpf1/N1+7QSp2
         f4sZfI8uRcNHjrbZnGkxgzXFOCGTD5jK1r5jbEenglfBZOATs//vEWvKLkkajQiIkQXJ
         sLQv7q5fOrj7oiVGuBtDJuv8UYtiYQNi3C44Zw6DhDli4TvzR6JvDQAMhCfGCsVUi70b
         kfnaYlpbi9r7ldgDg1wa9vBIy0LBu7C97zwKpDqG7eSRKq/lOcE/hyFbuvLdoS3LFVUS
         x8I+YUAGruimWrCmofEujBWMgvl6Cb/1voRJA4eNWBQIijfInGe+l8oMR6bQ2wOcanCj
         ZtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnNpAp3aE8fQN7wBOIfnQYPkKJsQ6+pg68kkULOUDHI=;
        b=q4Q4s4jYdwQ46UqiGjT5PCgOCDNqWpCeoNtwb4HVBeBmPGSHlD3X09WGggUumWXvqg
         L/LOHxOjBj6iSdYXUusSzOW08Q1gqpjoPzCbHZsSJbLXGyER0C2lR7IYeaLCzMsN/QgX
         HJWzS/S+N2H92Kyg7S3FDhuxJkSSOQQGfRHdEIUbkFn+NfnE6HJiiRVZHGua9+8ipgJB
         wVQuggABHvwgdhemuii+9KeOaqbIBU86FyX608fVG7yJUsRvw/GwY/7/ve/jY/7ODp7g
         KMcVTfGYuqvP4/Xf9gFsAzA45Exqf2lvjEDHG9hi5oD0WDdx2/ns2k9KgOsXWngifD3Q
         N7Rg==
X-Gm-Message-State: AOAM533l8IRbIaGPmiXsPGzxiA3+SboYYncIxczLvLnHs6RIn6IbqLQk
        a7JHaVwgZZXbYNQ4/ALw97GgBW9flcQMh2WIiCyLxcdtHnpRbw==
X-Google-Smtp-Source: ABdhPJxnXenwcTRZYMLLSyk5zFmQOcPsC/dBDOzzuXa1hyV6+mz7O24GwKwRVs7UPKxiw+MIW7Y0jqggzDtjzVo92Lg=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr12613726wro.184.1604942892790;
 Mon, 09 Nov 2020 09:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20201109112319.264511-1-alexandre.chartre@oracle.com> <20201109112319.264511-14-alexandre.chartre@oracle.com>
In-Reply-To: <20201109112319.264511-14-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 9 Nov 2020 09:28:01 -0800
Message-ID: <CALCETrX-cN8zcSNZnmEw=0dL+mkaqkWVMdE2FkGTfUFR+Si=Bg@mail.gmail.com>
Subject: Re: [RFC][PATCH 13/24] x86/pti: Extend PTI user mappings
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 3:22 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> Extend PTI user mappings so that more kernel entry code can be executed
> with the user page-table. To do so, we need to map syscall and interrupt
> entry code,

Probably fine.

> per cpu offsets (__per_cpu_offset, which is used some in
> entry code),

This likely already leaks due to vulnerable CPUs leaking address space
layout info.

> the stack canary,

That's going to be a very tough sell.
