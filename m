Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09525296E48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463539AbgJWMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:18:35 -0400
Received: from verein.lst.de ([213.95.11.211]:55858 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463485AbgJWMSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:18:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01A8467373; Fri, 23 Oct 2020 14:18:31 +0200 (CEST)
Date:   Fri, 23 Oct 2020 14:18:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Message-ID: <20201023121831.GA18499@lst.de>
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn> <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com> <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn> <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com> <20201023091408.GA5201@lst.de> <CAPDyKFpgEcEv8FH59ntmeQADEyCs6aiS8P0tEaru858DRQup=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpgEcEv8FH59ntmeQADEyCs6aiS8P0tEaru858DRQup=A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:12:19PM +0200, Ulf Hansson wrote:
> If I understand you correctly, you are saying that the controller
> should be able to communicate (upwards to the block layer) its known
> write protect state for the corresponding NVMe device, during
> initialization?

Yes.
