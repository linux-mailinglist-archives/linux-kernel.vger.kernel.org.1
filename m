Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F272F4C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAMNqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:46:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:44557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbhAMNqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610545492;
        bh=FeQ9LoOHwuLLcTo2b9xHbgXFNtYCZq4IltZO8nlbpCs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=HFsiXcU5bFA9JmK3AVwI7msIxvHvYbp6BlPGE09peNDm5pmAicHoSHs1JU8VNjQkQ
         rKUStnExKhGA8xCJpmh6A0Ku6YUPkXA1T/qlkg7vqxRJAGxgo4o6fHqCWJxgNF8meg
         glkUrke+fNU9shmcGeqI7qwTtnC7b8PkFa0tLvWs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([84.171.155.217]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs4Z-1kDN931U13-00mp4B; Wed, 13
 Jan 2021 14:44:52 +0100
Date:   Wed, 13 Jan 2021 14:44:51 +0100
From:   Marcus Huewe <suse-tux@gmx.de>
To:     oleg@redhat.com
Cc:     linux-kernel@vger.kernel.org, suse-tux@gmx.de
Subject: [PATCH] ptrace: Remove redundant code in ptrace_attach
Message-ID: <53924ce0d6f0c15575b5d7dbef2a8038bc27b4ed.1610544906.git.suse-tux@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:azk3k22lDsIfB7uhLn5x0dty+7XRxTPXkcpR471QCKPUaXP8ymd
 VGNctyvgvToHWHEfhR8G78FAZIa3YZ68kMpfEhiXWn8wWU4BVwrLksw2N8QmXaurSgf0wp2
 +QCFFSPNEHHrLmdV5YHW81ZtJ24BYIMuyqokgtkQ4dmToDuLnPwdgXYsjPXYVQytUKIBlmf
 ZKdujpbuHliZ1YKhsyGMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:imYpXO1rRgQ=:/Xd+0hNJbvhwO7MnjNsRdr
 lyg7skN1vTW4Qd8G82bhSNO9CCbSUuF1IsazVACtJ4tKlDY2WWS7ilyPIuGw6Uv8IYw2MSZIF
 2GEpUzgRJB8XsssO/Y/hGCTssee1iKLz0fUib2SFFNCdwqsFopyQnjaSmsYdSLlPJLq4P1NtB
 By7YWl1J0hRUS/PFSSqwiDvKQylppYkFsPDKyssGtShM99ec01CaiY8ZAxFcBSqwW4k9NQP+s
 8sg2MjqptZ354CrqrlhKaDWSeOeOS7tqwrjI1kTS1C7UnAtHrGaYp/aZS+O1ALxTsmz54zgaP
 byiRJIOfzLLT0o7YRj6d+ImFLikL3vouvy3P/BL/QilD0+xfpX40uN+n9lJwOL6E3D6iZZVq4
 5I6wZhhMf3O27F36NtCXIX5SDv4nl6u05eewEyRK5Qhgt3br4kkXj3CPn+vCPTKoqsTfkE5cD
 HkM0R95NgWNhjv6ZGjL2EpUp7/UI55NyTkdW8OauI0Zezh2KRsYWG9YfSEG/Bdipn1uwsP+0F
 IKPf/dsdwCn5Z8tI/Sd3qdRhDBHA3ioFIEyQOUFDEvcvyIG5MzQ3QWH4UfxL8QC7CeLiOflBZ
 qHxKABJRpcqmFj3LexPC9BEeK8dcEHJQtIJjSYzFVPS80s2bwzUQfcVBa8Lyxf4OveEMUp5MC
 g1sGcjlz0v0J9lohDhyEZXVe18/I/g9IpZipa2HJNCMI5uuHaj2MxcCOrMWxPYktEVXXumltO
 AAYMCRx8hZ5y3n45UOwnAkhVKGh1BvDGLi5FtkWeGSDYIcPzsVf7DR7gcV4OW0RQitv7Vm7IN
 tCIW1NwbT6ImqKdYU3n+Yy2XGuOoH3YS3bmOgMHdoAUvdkrQmr/m3MHOvy3qRDmwtatR2E+AY
 l63OqnfQt5X2sxZx7xYw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a PTRACE_SEIZE request, the PT_SEIZED flag is always set
at the beginning of ptrace_attach. Hence, there is no need to set
it again (neither "flags" nor "seize" are modified in between/after
the initial assignment).

Signed-off-by: Marcus Huewe <suse-tux@gmx.de>
=2D--
 kernel/ptrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 61db50f7ca86..059fce2ad53c 100644
=2D-- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -402,8 +402,6 @@ static int ptrace_attach(struct task_struct *task, lon=
g request,
 	if (task->ptrace)
 		goto unlock_tasklist;

-	if (seize)
-		flags |=3D PT_SEIZED;
 	task->ptrace =3D flags;

 	ptrace_link(task, current);
=2D-
2.29.2

