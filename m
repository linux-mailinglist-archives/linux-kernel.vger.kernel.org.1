Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D925223571F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 15:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHBNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 09:34:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47499 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHBNe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:34:57 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BKMSw4507z9sSt; Sun,  2 Aug 2020 23:34:56 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20200415012343.919255-1-alastair@d-silva.org>
References: <20200415012343.919255-1-alastair@d-silva.org>
Subject: Re: [PATCH 0/2] powerpc: OpenCAPI Cleanup
Message-Id: <159637523498.42190.4746198134743863254.b4-ty@ellerman.id.au>
Date:   Sun,  2 Aug 2020 23:34:56 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 11:23:41 +1000, Alastair D'Silva wrote:
> These patches address checkpatch & kernel doc warnings
> in the OpenCAPI infrastructure.
> 
> Alastair D'Silva (2):
>   ocxl: Remove unnecessary externs
>   ocxl: Address kernel doc errors & warnings
> 
> [...]

Applied to powerpc/next.

[1/2] ocxl: Remove unnecessary externs
      https://git.kernel.org/powerpc/c/c75d42e4c768c403f259f6c7f6217c850cf11be9
[2/2] ocxl: Address kernel doc errors & warnings
      https://git.kernel.org/powerpc/c/3591538a31af37cf6a2d83f1da99e651a822af8b

cheers
