Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90481E9627
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 09:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgEaHe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 03:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgEaHe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:34:27 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 May 2020 00:34:27 PDT
Received: from vsmtp92.cm.dti.ne.jp (vsmtp92.cm.dream.jp [IPv6:2001:2e8:702::236:70:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43B6EC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 00:34:27 -0700 (PDT)
Received: from dream.jp (p1975138-ipoe.ipoe.ocn.ne.jp [153.139.180.137]) by vsmtp92.cm.dti.ne.jp (3.11v) with ESMTP AUTH id 04V7SqIl012778 for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 16:28:52 +0900 (JST)
Message-Id: <202005310728.04V7SqIl012778@vsmtp92.cm.dti.ne.jp>
From:   Ishida Takashi <jade2@dream.jp>
To:     linux-kernel@vger.kernel.org
Subject: Red Hat Enterprise Linux 8 on Supercomputer Fugaku
Date:   Sun, 31 May 2020 16:28:52 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: HidemaruMail 6.94Beta13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Outline of the Development of the Supercomputer Fugaku

> OS   Red Hat Enterprise Linux 8 ON Supercomputer Fugaku

https://www.r-ccs.riken.jp/en/overview/aboutus
https://www.r-ccs.riken.jp/en/
https://www.r-ccs.riken.jp/en/postk/project/outline

Programming Language and Library

Compiler 	Fortran2008 & Fortran2018 subset
C11 & GNU and Clang extensions
C++14 & C++17 subset and GNU and Clang extensions
OpenMP 4.5 & OpenMP 5.0 subset
Java
Parallel Programming 	XcalableMP
FDPS
Script Language 	Python + Numpy + Scipy, Ruby
Math Library 	BLAS, LAPACK, ScaLAPACK
SSL II (Fujitsu)
EigenExa, Kevd, Batched BLAS, 2.5D-PDGEMM

System Software

OS	Red Hat Enterprise Linux 8                (Red Hat Linux !)
McKernel
MPI	Fujitsu MPI (Based on OpenMPI), RIKEN-MPICH (Based on MPICH)
File IO	LLIO
Application-oriented file IO libraries
