Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D981E45A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbgE0OVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388841AbgE0OVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:21:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD0C2084C;
        Wed, 27 May 2020 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590589264;
        bh=DgOjfhqIFRNoImLgp3PyGdGgSwtVwPALyFaKrh2la24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWny30Q0Sd+wQYpaYUbpsIKavVjh405V0Ux5Gzh0Pt99+7LLTt3gs4vTZ5QijjmL0
         6MEEwk5aqfBu8Pt/uprH7CCt+RXEkkkbPeHJapnOizcKgA031yGZnZRApatgA3SoPL
         Ia+4+6M2ZTyvwzJ3o6HsVmuq7tpGP8CQsQblL5n0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7588640AFD; Wed, 27 May 2020 11:20:57 -0300 (-03)
Date:   Wed, 27 May 2020 11:20:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf jvmti: Fix demangling Java symbols
Message-ID: <20200527142057.GF14219@kernel.org>
References: <20200427061520.24905-1-nick.gasson@arm.com>
 <20200427061520.24905-4-nick.gasson@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427061520.24905-4-nick.gasson@arm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 27, 2020 at 02:15:16PM +0800, Nick Gasson escreveu:
> For a Java method signature like:
> 
>     Ljava/lang/AbstractStringBuilder;appendChars(Ljava/lang/String;II)V
> 
> The demangler produces:
> 
>     void class java.lang.AbstractStringBuilder.appendChars(class java.lang., shorttring., int, int)
> 
> The arguments should be (java.lang.String, int, int) but the demangler
> interprets the "S" in String as the type code for "short". Correct this
> and two other minor things:
> 
> - There is no "bool" type in Java, should be "boolean".
> 
> - The demangler prepends "class" to every Java class name. This is not
>   standard Java syntax and it wastes a lot of horizontal space if the
>   signature is long. Remove this as there isn't any ambiguity between
>   class names and primitives.
> 
> Also added a test case.

So, I took this and split into a patch for the new 'perf test java' and
then the fix, so that we can see the problem being detected and then
apply the fix and see it fixed, the last patch in this series thus
became:


commit 341e11c1d445999932da3f5d626c9fe096949ae3
Author: Nick Gasson <nick.gasson@arm.com>
Date:   Mon Apr 27 14:15:16 2020 +0800

    perf jvmti: Fix demangling Java symbols
    
    For a Java method signature like:
    
        Ljava/lang/AbstractStringBuilder;appendChars(Ljava/lang/String;II)V
    
    The demangler produces:
    
        void class java.lang.AbstractStringBuilder.appendChars(class java.lang., shorttring., int, int)
    
    The arguments should be (java.lang.String, int, int) but the demangler
    interprets the "S" in String as the type code for "short". Correct this
    and two other minor things:
    
    - There is no "bool" type in Java, should be "boolean".
    
    - The demangler prepends "class" to every Java class name. This is not
      standard Java syntax and it wastes a lot of horizontal space if the
      signature is long. Remove this as there isn't any ambiguity between
      class names and primitives.
    
    Committer notes:
    
    This was split from a larger patch that also added a java demangler
    'perf test' entry, that, before this patch shows the error being fixed
    by it:
    
      $ perf test java
      65: Demangle Java                                         : FAILED!
      $ perf test -v java
      Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
      65: Demangle Java                                         :
      --- start ---
      test child forked, pid 307264
      FAILED: Ljava/lang/StringLatin1;equals([B[B)Z: bool class java.lang.StringLatin1.equals(byte[], byte[]) != boolean java.lang.StringLatin1.equals(byte[], byte[])
      FAILED: Ljava/util/zip/ZipUtils;CENSIZ([BI)J: long class java.util.zip.ZipUtils.CENSIZ(byte[], int) != long java.util.zip.ZipUtils.CENSIZ(byte[], int)
      FAILED: Ljava/util/regex/Pattern$BmpCharProperty;match(Ljava/util/regex/Matcher;ILjava/lang/CharSequence;)Z: bool class java.util.regex.Pattern$BmpCharProperty.match(class java.util.regex.Matcher., int, class java.lang., charhar, shortequence) != boolean java.util.regex.Pattern$BmpCharProperty.match(java.util.regex.Matcher, int, java.lang.CharSequence)
      FAILED: Ljava/lang/AbstractStringBuilder;appendChars(Ljava/lang/String;II)V: void class java.lang.AbstractStringBuilder.appendChars(class java.lang., shorttring., int, int) != void java.lang.AbstractStringBuilder.appendChars(java.lang.String, int, int)
      FAILED: Ljava/lang/Object;<init>()V: void class java.lang.Object<init>() != void java.lang.Object<init>()
      test child finished with -1
      ---- end ----
      Demangle Java: FAILED!
      $
    
    After applying this patch:
    
      $ perf test  java
      65: Demangle Java                                         : Ok
      $
    
    Signed-off-by: Nick Gasson <nick.gasson@arm.com>
    Reviewed-by: Ian Rogers <irogers@google.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Tested-by: Ian Rogers <irogers@google.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lore.kernel.org/lkml/20200427061520.24905-4-nick.gasson@arm.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index 6fb7f34c0814..39c05200ed65 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -15,7 +15,7 @@ enum {
 	MODE_CLASS  = 1,
 	MODE_FUNC   = 2,
 	MODE_TYPE   = 3,
-	MODE_CTYPE  = 3, /* class arg */
+	MODE_CTYPE  = 4, /* class arg */
 };
 
 #define BASE_ENT(c, n)	[c - 'A']=n
@@ -27,7 +27,7 @@ static const char *base_types['Z' - 'A' + 1] = {
 	BASE_ENT('I', "int" ),
 	BASE_ENT('J', "long" ),
 	BASE_ENT('S', "short" ),
-	BASE_ENT('Z', "bool" ),
+	BASE_ENT('Z', "boolean" ),
 };
 
 /*
@@ -59,15 +59,16 @@ __demangle_java_sym(const char *str, const char *end, char *buf, int maxlen, int
 
 		switch (*q) {
 		case 'L':
-			if (mode == MODE_PREFIX || mode == MODE_CTYPE) {
-				if (mode == MODE_CTYPE) {
+			if (mode == MODE_PREFIX || mode == MODE_TYPE) {
+				if (mode == MODE_TYPE) {
 					if (narg)
 						rlen += scnprintf(buf + rlen, maxlen - rlen, ", ");
 					narg++;
 				}
-				rlen += scnprintf(buf + rlen, maxlen - rlen, "class ");
 				if (mode == MODE_PREFIX)
 					mode = MODE_CLASS;
+				else
+					mode = MODE_CTYPE;
 			} else
 				buf[rlen++] = *q;
 			break;
@@ -120,7 +121,7 @@ __demangle_java_sym(const char *str, const char *end, char *buf, int maxlen, int
 			if (mode != MODE_CLASS && mode != MODE_CTYPE)
 				goto error;
 			/* safe because at least one other char to process */
-			if (isalpha(*(q + 1)))
+			if (isalpha(*(q + 1)) && mode == MODE_CLASS)
 				rlen += scnprintf(buf + rlen, maxlen - rlen, ".");
 			if (mode == MODE_CLASS)
 				mode = MODE_FUNC;
